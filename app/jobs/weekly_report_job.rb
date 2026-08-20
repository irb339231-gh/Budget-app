class WeeklyReportJob < ApplicationJob
  queue_as :default

  def perform
    User.where(email_notification: true).each do |user|
      ReportMailer.weekly_report(user).deliver_now
    end
  end
end
