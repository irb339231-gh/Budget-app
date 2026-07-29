require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "有効なユーザーは保存できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nameがない場合は無効" do
      user = build(:user, name: " ")
      expect(user).not_to be_valid
    end

    it "nameが20文字より長い場合は無効" do
      user = build(:user, name: "a" * 21)
      expect(user).not_to be_valid
    end

    it "emailがない場合は無効" do
      user = build(:user, email: " ")
      expect(user).not_to be_valid
    end

    it "emailが重複している場合は無効" do
      create(:user, email: "duplicate@example.com")
      user = build(:user, email: "duplicate@example.com")
      expect(user).not_to be_valid
    end

    it "passwordが6文字未満の場合は無効" do
      user = build(:user, password: "12345")
      expect(user).not_to be_valid
    end
  end

  describe "算出ロジック" do
    it "total_incomeが正しく計算される" do
      user = create(:user)
      create(:income, user: user, amount: 1000000)
      create(:income, user: user, amount: 500000)
      expect(user.total_income).to eq 1500000
    end

    it "total_future_expenseが正しく計算される" do
      user = create(:user)
      create(:future_expense, user: user, amount: 300000)
      create(:future_expense, user: user, amount: 200000)
      expect(user.total_future_expenses).to eq 500000
    end

    it "total_fixed_costが正しく計算される" do
      user = create(:user,
        job_search_start_month: Date.new(2026, 7, 1),
        job_search_end_month: Date.new(2026, 10, 1))
      create(:fixed_cost, user: user, amount: 30000)
      create(:fixed_cost, user: user, amount: 20000)
      expect(user.total_fixed_costs).to eq 150000
    end

    it "job_search_monthsが正しく計算される" do
     user = create(:user,
        job_search_start_month: Date.new(2026, 7, 1),
        job_search_end_month: Date.new(2026, 10, 1))
      expect(user.job_search_months).to eq 3
    end

    it "開始月か終了月がない場合job_search_monthsは0を返す" do
     user = create(:user,
        job_search_start_month: nil,
        job_search_end_month: nil)
      expect(user.job_search_months).to eq 0
    end

    it "available_amountが正しく計算される" do
      user = create(:user,
        job_search_start_month: Date.new(2026, 7, 1),
        job_search_end_month: Date.new(2026, 10, 1))
      create(:income, user: user, amount: 1000000)
      create(:future_expense, user: user, amount: 300000)
      create(:fixed_cost, user: user, amount: 30000)
      expect(user.available_amount).to eq 610000
    end
  end
end
