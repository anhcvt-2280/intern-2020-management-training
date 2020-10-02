class UserCourseSubject < ApplicationRecord
  after_create :save_user_task
  after_update :update_user_course_progress, if: proc{|ucs| ucs.done?}

  belongs_to :course_subject
  belongs_to :user
  belongs_to :user_course
  has_many :user_tasks, dependent: :destroy

  delegate :course_id, to: :course_subject,
    prefix: Settings.prefix.course_subject

  enum status: {inprogress: 0, done: 1}

  scope :status, ->(status){where status: status if status.present?}
  scope :status_fb, ->(status){find_by status: status}
  scope :task_done, (lambda do |course_id|
    select("COUNT(user_tasks.user_course_subject_id) AS task_done_user,
           	course_subjects.subject_id")
        .joins(:course_subject, :user_tasks)
        .where(user_tasks: {status: Settings.validates.model.user_task.done},
               course_subjects: {course_id: course_id})
        .group("user_tasks.user_course_subject_id")
        .order(priority: :asc)
  end)
  scope :task_of_user, (lambda do |user_id|
    select("user_tasks.status AS user_task_status", "tasks.name")
        .joins(:course_subject, [user_tasks: :task])
        .where(user_course_subjects: {user_id: user_id})
  end)
  scope :by_user, ->(user_id){where user_id: user_id if user_id.present?}
  scope :by_subject, (lambda do |subject_id|
    where course_subjects: {subject_id: subject_id} if subject_id.present?
  end)
  scope :opening_course, (lambda do
    joins(:course_subject).merge CourseSubject.opening_course
  end)
  scope :deadline_between, (lambda do |date_from, date_to|
    where("deadline <= ? and deadline >= ?", date_to, date_from)
  end)

  private

  def save_user_task
    task_ids = course_subject.subject.task_ids
    error_user_task if task_ids.blank?
    task_ids.each do |task_id|
      data = {task_id: task_id, user_course_subject_id: id,
              status: Settings.progress_course.percent.zero}
      error_user_task unless UserTask.new(data).save
    end
  end

  def error_user_task
    errors.add :base, :user_task, message: I18n.t("notice.error")
    raise ActiveRecord::Rollback
  end

  def update_user_course_progress
    all = user_course.user_course_subjects
    done = all.done
    data = {progress: done.size * Settings.done_percentage / all.size}
    err_user_course unless user_course.update data
  end

  def err_user_course
    errors.add :base, :user_course, message: I18n.t("notice.error")
    raise ActiveRecord::Rollback
  end
end
