class ExpendituresController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenditures = current_user.expenditures.where(category: :income)
  end

  def new
    @expenditure = current_user.expenditures.build
  end

  def create
    @expenditure = current_user.expenditures.build(expenditure_params)
    @expenditure.category = :income
    if @expenditure.save
      redirect_to edit_all_expenditures_path, notice: "収入を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_all
    @expenditures = current_user.expenditures.where(category: :income)
  end

  def edit
    @expenditure = current_user.expenditures.find(params[:id])
    @expenditures = current_user.expenditures.where(category: :income)
  end

  def update
    @expenditure = current_user.expenditures.find(params[:id])
    if @expenditure.update(expenditure_params)
      redirect_to edit_all_expenditures_path, notice: "収入を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expenditure = current_user.expenditures.find(params[:id])
    @expenditure.destroy
    redirect_to edit_all_expenditures_path, notice: "収入を削除しました"
  end

  private

  def expenditure_params
    params.require(:expenditure).permit(:name, :amount)
  end
end
