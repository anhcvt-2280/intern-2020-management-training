class User < ApplicationRecord
  USER_PARAMS_PERMIT = %i(name email password date_of_birth address gender
    program_language_id position_id department_id school_id office_id
    image password_confirmation).freeze
  VALID_EMAIL_REGEX = Settings.REGEX.model.user.email

  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_course_subjects, dependent: :destroy
  belongs_to :school
  belongs_to :program_language
  belongs_to :position
  belongs_to :department
  belongs_to :office

  mount_uploader :image, UserUploader

  delegate :name, to: :school, prefix: true
  delegate :name, to: :program_language, prefix: true
  delegate :name, to: :position, prefix: true
  delegate :name, to: :department, prefix: true
  delegate :name, to: :office, prefix: true
  delegate :task_done, to: :user_course_subjects

  belongs_to :school
  belongs_to :program_language
  belongs_to :position
  belongs_to :department
  belongs_to :office

  delegate :name, to: :school, prefix: true
  delegate :name, to: :program_language, prefix: true
  delegate :name, to: :position, prefix: true
  delegate :name, to: :department, prefix: true
  delegate :name, to: :office, prefix: true

  validates :name, presence: true,
            length: {maximum: Settings.validates.model.user.name.max_length}
  validates :email, presence: true,
            length: {maximum: Settings.validates.model.user.email.max_length},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true,
            length: {minimum: Settings.validates.model.user.pwd.min_length},
            allow_nil: true
  validates :address,
            length: {maximum: Settings.validates.model.user.name.max_length}
  validates :program_language_id, presence: true
  validates :position_id, presence: true
  validates :department_id, presence: true
  validates :school_id, presence: true
  validates :office_id, presence: true
  validates :date_of_birth, presence: true
  validate :birthday_cannot_be_in_future, :birthday_old_men

  mount_uploader :image, UserUploader

  enum role: {trainee: 0, trainer: 1}, _prefix: true
  enum gender: {male: 1, female: 0}, _prefix: true

  scope :by_name, ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
  scope :exclude_ids, ->(ids){where.not id: ids if ids.present?}

  has_secure_password

  def birthday
    date_of_birth.strftime Settings.validates.model.course.date_format
  end

  private

  def birthday_cannot_be_in_future
    return unless date_of_birth > Time.zone.today

    errors.add :date_of_birth,
               I18n.t("trainers.users.new.error_birthday_in_future")
  end

  def birthday_old_men
    return unless date_of_birth < 100.years.ago

    errors.add :date_of_birth,
               I18n.t("trainers.users.new.error_birthday_in_oldmen")
  end
end
