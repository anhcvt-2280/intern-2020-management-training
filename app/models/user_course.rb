class UserCourse < ApplicationRecord
  after_create :save_user_course_subject

  belongs_to :user
  belongs_to :course
  has_many :user_course_subjects, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  scope :by_course, ->(id){where course_id: id if id.present?}

  private

  def save_user_course_subject
    return unless course_subject_ids = load_course_subjects_ids

    course_subject_ids.each do |course_subject|
      data = {user_id: user_id, course_subject_id: course_subject,
              user_course_id: id,
              status: Settings.progress_course.percent.zero,
              progress: Settings.progress_course.percent.zero,
              deadline: Time.zone.now}
      error_user_course_subject unless UserCourseSubject.new(data).save
    end
  end

  def error_user_course_subject
    errors.add :base, :user_course_subject, message: I18n.t("notice.error")
    raise ActiveRecord::Rollback
  end

  def load_course_subjects_ids
    course.course_subject_ids.presence
  end
end
