class ReminderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.weekly_reminder.subject
  #
  def weekly_reminder(user)
    @user = user
    
    mail(to: @user.email, subject: "【Budget App】Weekly Reminder")
  end
end
