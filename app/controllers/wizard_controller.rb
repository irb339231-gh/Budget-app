class WizardController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!

  steps :step1, :step2, :step3, :step4

  def show
    @user = current_user
    @incomes = current_user.expenditures.where(category: :income)
    @future_expenses = current_user.expenditures.where(category: :future_expense)
    @fixed_costs = current_user.expenditures.where(category: :fixed_cost)
    render_wizard
  end

  def update
    @user = current_user
    case step
    when :step1
      @user.update(job_search_params)
    when :step2
      if income_params[:name].present? && income_params[:amount].present?
        @expenditure = current_user.expenditures.build(income_params)
        @expenditure.category = :income
        if @expenditure.save
          # 成功時の処理
          redirect_to wizard_path(:step2), notice: " 収入を追加しました。"
        else
          redirect_to wizard_path(:step2), notice: "入力内容を確認してください。"
        end
        return
      else
        redirect_to wizard_path(:step2), alert: "収入名と金額を入力してください。"
        return
      end

    when :step3
      if future_expense_params[:name].present? && future_expense_params[:amount].present?
        @expenditure = current_user.expenditures.build(future_expense_params)
        @expenditure.category = :future_expense
        if @expenditure.save
          redirect_to wizard_path(:step3), notice: " 今後の支出を追加しました。"
        else
          redirect_to wizard_path(:step3), notice: "入力内容を確認してください。"
        end
        return
      else
        redirect_to wizard_path(:step3), alert: "支出名と金額を入力してください。"
        return
      end

    when :step4
      if fixed_cost_params[:name].present? && fixed_cost_params[:amount].present?
        @expenditure = current_user.expenditures.build(fixed_cost_params)
        @expenditure.category = :fixed_cost
        if @expenditure.save
          redirect_to wizard_path(:step4), notice: " 固定費を追加しました。"
        else
          redirect_to wizard_path(:step4), notice: "入力内容を確認してください。"
        end
        return
      else
        redirect_to wizard_path(:step4), alert: "費用名と金額を入力してください。"
        return
      end
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
