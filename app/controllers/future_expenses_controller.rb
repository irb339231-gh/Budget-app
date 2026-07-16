class FutureExpensesController < ApplicationController
before_action :authenticate_user!
before_action :set_future_expense, only: [:edit, :update, :destroy]

  def index
    @future_expenses = current_user.expenditures.where(category: :future_expense)
  end

  def new
    @future_expense = current_user.expenditures.build
  end

  def create
    @future_expense = current_user.expenditures.build(future_expense_params)
    @future_expense.category = :future_expense
    if @future_expense.save
      redirect_to future_expenses_path, notice: "将来の支出を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_all
    @future_expenses = current_user.expenditures.where(category: :future_expense)
  end

  def edit
  end

  def update
    if @future_expense.update(future_expense_params)
      redirect_to edit_all_future_expenses_path, notice: "将来の支出を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @future_expense.destroy
    redirect_to edit_all_future_expenses_path, notice: "将来の支出を削除しました"
  end

  private

  def future_expense_params
    params.require(:future_expense).permit(:name, :amount)
  end

  def set_future_expense
    @future_expense = current_user.expenditures.find(params[:id])
  end
end
