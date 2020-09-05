class Subject < ApplicationRecord
  SUBJECT_NAME_REGEX = Settings.REGEX.model.subject.name
  PERMITTED_CREATE_ATTRS = [:name, :duration, :note, :image, :image_cache,
    tasks_attributes: [:id, :name, :_destroy].freeze].freeze
  TASK_MIN = Settings.validates.model.subject.task_min_size
  IMG_MAX_SIZE = Settings.validates.model.subject.image.max_size.MB

  mount_uploader :image, ImageUploader, reject_if:
    (proc do |param|
      param[:image].blank? || param[:image_cache].blank? || param[:id].blank?
    end)
  has_many :tasks, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :topic_subjects, dependent: :destroy
  has_many :topics, through: :topic_subjects

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :tasks, allow_destroy: true,
                                reject_if: :reject_tasks?

  validates :name, presence: true, uniqueness: true,
            length: {
              minimum: Settings.validates.model.subject.name.min_length,
              maximum: Settings.validates.model.subject.name.max_length
            },
            format: {with: SUBJECT_NAME_REGEX}
  validates :duration, presence: true,
            numericality: {
              greater_than: Settings.validates.model.subject.duration.min
            }
  validates :note, allow_nil: true,
            length: {
              maximum: Settings.validates.model.subject.note.max_length
            }
  validates_processing_of :image
  validate :validate_img_size
  validate :validate_min_count

  scope :by_name, ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
  scope :exclude_ids, ->(ids){where.not id: ids if ids.present?}
  scope :by_created_at, ->{order created_at: :desc}
  scope :order_priority, ->{order priority: :asc}
  scope :total_time_subjects, ->{sum :duration}
  scope :by_id, ->(id){where id: id if id.present?}

  def started_at
    created_at.strftime Settings.validates.model.course.date_format
  end

  def ended_at started_at
    ended_at = Time.zone.strptime(started_at, "%d-%m-%Y") + duration.to_int.days
    ended_at.strftime Settings.validates.model.course.date_format
  end

  private

  def validate_img_size
    return unless image.size > (IMG_MAX_SIZE * 1024 * 1024)

    errors.add :image, I18n.t("model.subject.val_img_size", size: IMG_MAX_SIZE)
  end

  def valid_min?
    return if tasks.blank?

    tasks.size > TASK_MIN - 1
  end

  def validate_min_count
    return if valid_min?

    errors[:tasks] << I18n.t("model.subject.val_task_size", size: TASK_MIN)
  end

  def reject_tasks? attributes
    attributes["name"].blank?
  end
end
