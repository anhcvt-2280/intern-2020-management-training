class CourseSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :course
  has_many :user_course_subjects, dependent: :destroy

  delegate :task_of_user, to: :user_course_subjects

  scope :by_course, ->(id){where course_id: id if id.present?}

  def started_at
    created_at.strftime Settings.validates.model.course.date_format
  end
end
