class ReportMailer < ApplicationMailer
  def weekly_report(user)
    @user = user
    @available_amount = user.available_amount
    @monthly_available_amount = user.monthly_available_amount
    @daily_available_amount = user.daily_available_amount
    mail(to: @user.email, subject: '【Budget App】今週の使える金額レポート')
  end
end
