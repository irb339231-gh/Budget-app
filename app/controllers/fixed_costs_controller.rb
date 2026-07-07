class FixedCostsController < ApplicationController
  def index
    @fixed_costs = current_user.expenditures.where(category: :fixed_cost)
  end

  def new
    @fixed_cost = current_user.expenditures.build
  end

  def create
    @fixed_cost = current_user.expenditures.build(fixed_cost_params)
    @fixed_cost.category = :fixed_cost
    if @fixed_cost.save
      redirect_to fixed_costs_path, notice: "固定費を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_all
    @fixed_costs = current_user.expenditures.where(category: :fixed_cost)
  end

  def edit
    @fixed_cost = current_user.expenditures.find(params[:id])
  end

  def update
    @fixed_cost = current_user.expenditures.find(params[:id])
    if @fixed_cost.update(fixed_cost_params)
      redirect_to edit_all_fixed_costs_path, notice: "固定費を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def fixed_cost_params
    params.require(:fixed_cost).permit(:name, :amount)
  end
end
