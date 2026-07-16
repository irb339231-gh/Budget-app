require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "有効なユーザーは保存できる" do
    @user = build(:user)
    assert @user.valid?
  end

  test "nameがない場合は無効" do
    user = build(:user, name: "  ")
    assert_not user.valid?
  end

  test "nameが20文字より長い場合は無効" do
    user = build(:user, name: "a" * 21)
    assert_not user.valid?
  end

  test "emailがない場合は無効" do
    user = build(:user, email: "  ")
    assert_not user.valid?
  end

  test "emailが重複している場合は無効" do
    create(:user, email: "duplicate@example.com")
    user = build(:user, email: "duplicate@example.com")
    assert_not user.valid?
  end

  test "passwordが6文字未満の場合は無効" do
    user = build(:user, password: "12345")
    assert_not user.valid?
  end

  # 算出ロジックのテスト
  test "total_incomeが正しく計算される" do
    user = create(:user)
    create(:income, user: user, amount: 1000000)
    create(:income, user: user, amount: 500000)
    assert_equal 1500000, user.total_income
  end

  test "total_future_expensesが正しく計算される" do
    user = create(:user)
    create(:future_expense, user: user, amount: 300000)
    create(:future_expense, user: user, amount: 200000)
    assert_equal 500000, user.total_future_expenses
  end

  test "total_fixed_costsが正しく計算される" do
    user = create(:user)
    create(:fixed_cost, user: user, amount: 30000)
    create(:fixed_cost, user: user, amount: 20000)
    user.job_search_start_month = Date.new(2026, 7, 1)
    user.job_search_end_month = Date.new(2026, 10, 1)
    assert_equal 150000, user.total_fixed_costs
  end

  test "job_search_monthsが正しく計算される" do
    user = create(:user,
      job_search_start_month: Date.new(2026, 7, 1),
      job_search_end_month: Date.new(2026, 10, 1))
    assert_equal 3, user.job_search_months
  end

  test "開始月か終了月がない場合job_search_monthsは0を返す" do
    user = create(:user,
      job_search_start_month: nil,
      job_search_end_month: nil)
    assert_equal 0, user.job_search_months
  end

  test "available_amountが正しく計算される" do
    user = create(:user,
      job_search_start_month: Date.new(2026, 7, 1),
      job_search_end_month: Date.new(2026, 10, 1))
    create(:income, user: user, amount: 2000000)
    create(:future_expense, user: user, amount: 300000)
    create(:fixed_cost, user: user, amount: 30000)
    assert_equal 1610000, user.available_amount
  end
end
