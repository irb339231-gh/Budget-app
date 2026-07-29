require "rails_helper"

RSpec.describe Expenditure, type: :model do
  describe "バリデーション"
    it '有効な収入データは保存できる' do
      expenditure = build(:income)
      expect(expenditure).to be_valid
    end

    it "有効な将来の支出データは保存できる" do
      expenditure = build(:future_expense)
      expect(expenditure).to be_valid
    end

    it "有効な固定費データは保存できる" do
      expenditure = build(:fixed_cost)
      expect(expenditure).to be_valid
    end

    it "nameがない場合は無効" do
      expenditure = build(:income, name: " ")
      expect(expenditure).not_to be_valid
    end

    it "amountがない場合は無効" do
      expenditure = build(:income, amount: nil)
      expect(expenditure).not_to be_valid
    end

    it "amountが0以下の場合は無効" do
      expenditure = build(:income, amount: 0)
      expect(expenditure).not_to be_valid
    end

    it "amountが負の場合は無効" do
      expenditure = build(:income, amount: -100)
      expect(expenditure).not_to be_valid
    end

    it "categoryがない場合は無効" do
      expenditure = build(:income, category: nil)
      expect(expenditure).not_to be_valid
    end

  describe "enum" do
    it "categoryがincomeの場合は有効" do
      expenditure = build(:income)
      expect(expenditure.income?).to be true
    end

    it "categoryがfuture_expenseの場合は有効" do
      expenditure = build(:future_expense)
      expect(expenditure.future_expense?).to be true
    end

    it "categoryがfixed_costの場合は有効" do
      expenditure = build(:fixed_cost)
      expect(expenditure.fixed_cost?).to be true
    end
  end
end
