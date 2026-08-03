class WeeklyReminderJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      ReminderMailer.weekly_reminder(user).deliver_now
    end
  end
end
