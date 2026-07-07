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

  private

  def fixed_cost_params
    params.require(:expenditure).permit(:name, :amount)
  end
end
