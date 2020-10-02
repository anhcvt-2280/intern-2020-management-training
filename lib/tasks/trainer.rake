namespace :trainer do
  desc "send reminder mail about suject deadline"

  task send_reminder: :environment do
    puts "RUNNING job send reminder mail schedule"
    SendReminderMailJob.perform_later
    puts "-------- success"
  end
end
