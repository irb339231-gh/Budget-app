class UsersController < ApplicationController
  before_action :authenticate_user!

  def update_job_search
    if current_user.update(job_search_params)
      redirect_to home_path, notice: "転職活動期間を設定しました"
    else
      redirect_to home_path, alert: "設定に失敗しました"
    end
  end

  private

  def job_search_params
    params.require(:user).permit(
      :job_search_start_month,
      :job_search_end_month
    )
  end
end
