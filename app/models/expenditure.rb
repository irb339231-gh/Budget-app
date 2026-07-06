class Expenditure < ApplicationRecord
  belongs_to :user

  enum :category, { income: 0, future_expense: 1, fixed_cost: 2 }

  validates :name, presence: true
  validates :category, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
