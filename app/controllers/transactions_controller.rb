class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to home_path, notice: "取引を登録しました"
    else
      redirect_to home_path, alert: "取引の登録に失敗しました"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :category, :amount)
  end
end
