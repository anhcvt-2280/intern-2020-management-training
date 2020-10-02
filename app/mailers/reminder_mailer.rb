class ReminderMailer < ApplicationMailer
  def reminder_mail user, user_course_subject
    @user = user
    @user_course_subject = user_course_subject
    @course_subject = @user_course_subject.course_subject
    mail to: user.email, subject: I18n.t("mailers.reminder_title")
  end
end
