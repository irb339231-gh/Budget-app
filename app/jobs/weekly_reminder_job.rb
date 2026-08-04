class WeeklyReminderJob < ApplicationJob
  queue_as :default

  def perform
    User.where(email_notification: true).each do |user|
      ReminderMailer.weekly_reminder(user).deliver_now
    end
  end
end
