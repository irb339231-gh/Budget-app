class WizardController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!

  steps :step1, :step2, :step3, :step4

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    case step
    when :step1
      @user.update(job_search_params)
    when :step2
      @expenditure = current_user.expenditures.build(income_params)
      @expenditure.category = :income
      @expenditure.save
    when :step3
      @expenditure = current_user.expenditures.build(future_expense_params)
      @expenditure.category = :future_expense
      @expenditure.save
    when :step4
        @expenditure = current_user.expenditures.build(fixed_cost_params)
        @expenditure.category = :fixed_cost
        @expenditure.save
    end
    render_wizard @user
  end

  def finish_wizard_path
    current_user.update(wizard_completed: true)
    home_path
  end

  private

  def job_search_params
    params.require(:user).permit(
      :job_search_start_month,
      :job_search_end_month
    )
  end

  def income_params
    params.require(:income).permit(:name, :amount)
  end

  def future_expense_params
    params.require(:future_expense).permit(:name, :amount)
  end

  def fixed_cost_params
    params.require(:fixed_cost).permit(:name, :amount)
  end

end
