class WeeklyReportJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      ReportMailer.weekly_report(user).deliver_now
    end
  end
end
