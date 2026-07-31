class User < ApplicationRecord
  has_many :expenditures, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def available_amount
    total_income - total_future_expenses - total_fixed_costs - total_transactions_expenses + total_transactions_incomes
  end

  def daily_available_amount
    return 0 if job_search_days.zero? #daysが0の場合は除く
    available_amount / job_search_days
  end

  def weekly_available_amount
    return 0 if job_search_days.zero? #daysが0の場合は除く
    available_amount / (job_search_days / 7) #転職活動期間を7で割る
  end

  def monthly_available_amount
    return 0 if job_search_months.zero? #monthsが0の場合は除く
    available_amount / job_search_months
  end

  def job_search_days
    return 0 if job_search_start_month.nil? || job_search_end_month.nil?
    (job_search_end_month - job_search_start_month ).to_i
  end

  def job_search_months
    return 0 if job_search_start_month.nil? || job_search_end_month.nil?
    ((job_search_end_month.year - job_search_start_month.year) * 12 +
      (job_search_end_month.month - job_search_start_month.month)).abs
  end

  def total_income
    expenditures.where(category: :income).sum(:amount)
  end

  def total_future_expenses
    expenditures.where(category: :future_expense).sum(:amount)
  end

  def total_fixed_costs
    expenditures.where(category: :fixed_cost).sum(:amount) * job_search_months
  end

  def total_transactions_expenses
    transactions.where(category: :expense).sum(:amount)
  end

  def total_transactions_incomes
    transactions.where(category: :income).sum(:amount)
  end
end
