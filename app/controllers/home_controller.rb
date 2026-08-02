class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @available_amount = current_user.available_amount
    @daily_available_amount = current_user.daily_available_amount
    @weekly_available_amount = current_user.weekly_available_amount
    @monthly_available_amount = current_user.monthly_available_amount
    @available_amount_percentage = current_user.available_amount_percentage
  end
end
