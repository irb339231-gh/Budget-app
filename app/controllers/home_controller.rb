class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @available_amount = current_user.available_amount
  end
end
