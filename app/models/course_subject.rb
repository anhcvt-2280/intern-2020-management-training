class CourseSubject < ApplicationRecord
  after_create :save_user_course_subject
  after_update :update_deadline_user_course_subject

  belongs_to :subject
  belongs_to :course
  has_many :user_course_subjects, dependent: :destroy

  enum status: {start: 0, inprogress: 1, pending: 2, finished: 3}

  delegate :task_of_user, to: :user_course_subjects

  scope :by_course, ->(id){where course_id: id if id.present?}
  scope :order_by_priority, ->{order priority: :asc}
  scope :in_active, ->{where status: %i(inprogress pending)}
  scope :progress_user_course, (lambda do |user_id, course_id|
    select("user_course_subjects.progress")
    .joins(:user_course_subjects)
    .where(user_course_subjects: {user_id: user_id},
      course_subjects: {course_id: course_id})
  end)
  scope :by_course_and_subject, (lambda do |course_id, subject_id|
    find_by course_id: course_id, subject_id: subject_id
  end)
  scope :opening_course, ->{joins(:course).where courses: {status: :opening}}

  def started_at
    start_date.strftime Settings.validates.model.course.date_format
  end

  def ended_at
    end_date.strftime Settings.validates.model.course.date_format
  end

  def find_user_course_subject_by_user user_id
    user_course_subjects.by_user(user_id).first
  end

  private

  def save_user_course_subject
    return unless user_courses = load_user_courses

    user_courses.each do |user_course|
      next if user_course.id.blank?

      data = {user_id: user_course.user_id, course_subject_id: id,
              user_course_id: user_course.id,
              status: Settings.progress_course.percent.zero,
              progress: Settings.progress_course.percent.zero}

      error_user_course_subject unless UserCourseSubject.new(data).save
    end
  end

  def error_user_course_subject
    errors.add :base, :user_course_subject, message: I18n.t("notice.error")
    raise ActiveRecord::Rollback
  end

  def load_user_courses
    course.user_courses.presence
  end

  def update_deadline_user_course_subject
    user_course_subjects.each do |item|
      error_user_course_subject unless item.update deadline: end_date
    end
  end
end
