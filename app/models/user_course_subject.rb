class UserCourseSubject < ApplicationRecord
  belongs_to :course_subject
  belongs_to :user
  has_many :user_tasks, dependent: :destroy

  enum status: {doing: 0, done: 1}

  scope :status, ->(status){where status: status if status.present?}
  scope :task_done, (lambda do
    select("COUNT(user_tasks.user_course_subject_id) AS task_done,
           	course_subjects.subject_id")
        .joins(:course_subject, :user_tasks)
        .where(user_tasks: {status: 1})
        .group("user_tasks.user_course_subject_id")
        .order(priority: :asc)
  end)
  scope :task_of_user, (lambda do |user_id|
    select("user_tasks.status AS user_task_status", "tasks.name")
        .joins(:course_subject, [user_tasks: :task])
        .where(user_course_subjects: {user_id: user_id})
  end)
  scope :by_subject, (lambda do |id|
    where user_course_subjects: {course_subject_id: id} if id.present?
  end)
end
