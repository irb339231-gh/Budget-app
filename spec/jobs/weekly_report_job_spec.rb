require 'rails_helper'

RSpec.describe WeeklyReportJob, type: :job do
  describe "#perform" do
    let!(:user_with_notification) { create(:user, email_notification: true) }
    let!(:user_without_notification) { create(:user, email_notification: false) }

    it "メール通知がONのユーザーにメールを送信する" do
      expect {
        WeeklyReportJob.perform_now
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "メール通知がOFFのユーザーにはメールを送信しない" do
      user_with_notification.update(email_notification: false)
      expect {
        WeeklyReportJob.perform_now
      }.not_to change { ActionMailer::Base.deliveries.count }
    end
    
    it "複数のユーザーにメールを送信する" do
      create(:user, email_notification: true)
      expect {
        WeeklyReportJob.perform_now
      }.to change { ActionMailer::Base.deliveries.count }.by(2)
    end
  end
end
