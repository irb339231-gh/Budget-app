class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [ :destroy ]

  def index
    @transactions = current_user.transactions.order(created_at: :desc)
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to home_path, notice: "取引を登録しました"
    else
      redirect_to home_path, alert: "取引の登録に失敗しました"
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_path, notice: "取引を削除しました"
  end


  private
  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:name, :category, :amount)
  end
end
