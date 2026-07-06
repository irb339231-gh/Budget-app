class IncomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @incomes = current_user.expenditures.where(category: :income)
  end

  def new
    @income = current_user.expenditures.build
  end

  def create
    @income = current_user.expenditures.build(income_params)
    @income.category = :income
    if @income.save
      redirect_to incomes_path, notice: "収入を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_all
    @incomes = current_user.expenditures.where(category: :income)
  end

  def edit
    @income = current_user.expenditures.find(params[:id])
  end

  def update
    @income = current_user.expenditures.find(params[:id])
    if @income.update(income_params)
      redirect_to edit_all_incomes_path, notice: "収入を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @income = current_user.expenditures.find(params[:id])
    @income.destroy
    redirect_to edit_all_incomes_path, notice: "収入を削除しました"
  end

  private

  def income_params
    params.require(:income).permit(:name, :amount)
  end
end
