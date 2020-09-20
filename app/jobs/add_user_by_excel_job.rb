class AddUserByExcelJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 2

  def perform name
    puts "Test sidekiq"
  end
end
