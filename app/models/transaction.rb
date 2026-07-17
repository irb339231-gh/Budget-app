class Transaction < ApplicationRecord
  belongs_to :user

  enum :category, { expense: 0, income: 1 }

  validates :category, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end