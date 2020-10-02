class SendReminderMailJob < ApplicationJob
  queue_as :default

  def perform
    date_from = Time.zone.today
    date_to = date_from + Settings.time_reminder.to_i.days
    user_c_subjects = UserCourseSubject.opening_course.status(:inprogress)
                                       .deadline_between date_from, date_to
    user_c_subjects.each do |ucs|
      ReminderMailer.reminder_mail(ucs.user, ucs)
                    .deliver_later wait: Settings.sidekiq.wait.to_i.seconds
    end
  end
end
