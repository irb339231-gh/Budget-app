class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update_job_search
    if current_user.update(job_search_params)
      redirect_to home_path, notice: "転職活動期間を設定しました"
    else
      redirect_to home_path, alert: "設定に失敗しました"
    end
  end

  def update_email_notification
    if current_user.update(email_notification_params)
      if current_user.email_notification?
        redirect_to user_profile_path, notice: "メール通知設定をONにしました"
      else
        redirect_to user_profile_path, notice: "メール通知設定をOFFにしました"
      end
    else
      redirect_to user_profile_path, alert: "メール通知設定の更新に失敗しました"
    end
  end

  private

  def job_search_params
    params.require(:user).permit(
      :job_search_start_month,
      :job_search_end_month
    )
  end

  def email_notification_params
    params.require(:user).permit(:email_notification)
  end
end
