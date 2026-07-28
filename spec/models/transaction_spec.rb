require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "バリデーション" do
    it '有効な支出は保存できる' do
      transaction = build(:expense_transaction)
      expect(transaction).to be_valid
    end

    it '有効な収入データは保存できる' do
      transaction = build(:income_transaction)
      expect(transaction).to be_valid
    end

    it 'amountがない場合は無効' do
      transaction = build(:expense_transaction, amount: nil)
      expect(transaction).not_to be_valid
    end

    it 'amountが0以下の場合は無効' do
      transaction = build(:expense_transaction, amount: 0)
      expect(transaction).not_to be_valid
    end

    it 'amountが負の場合は無効' do
      transaction = build(:expense_transaction, amount: -100)
      expect(transaction).not_to be_valid
    end

    it 'categoryがない場合は無効' do
      transaction = build(:expense_transaction, category: nil)
      expect(transaction).not_to be_valid
    end
  end

  describe "enum" do
    it 'categoryがexpenseの場合は有効' do
      transaction = build(:expense_transaction)
      expect(transaction.expense?).to be true
    end

    it 'categoryがincomeの場合は有効' do
      transaction = build(:income_transaction)
      expect(transaction.income?).to be true
    end
  end
end
