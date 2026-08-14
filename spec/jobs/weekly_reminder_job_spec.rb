require "rails_helper"

RSpec.describe WeeklyReminderJob, type: :job do
  describe "#perform" do
    let!(:user_with_notification) { create(:user, email_notification: true) }
    let!(:user_without_notification) { create(:user, email_notification: false) }

    it "メール通知がONのユーザーにメールを送信する" do
      expect {
        WeeklyReminderJob.perform_now
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "メール通知がOFFのユーザーにはメールを送信しない" do
      user_with_notification.update(email_notification: false)
      expect {
        WeeklyReminderJob.perform_now
      }.not_to change { ActionMailer::Base.deliveries.count }
    end
  end
end
