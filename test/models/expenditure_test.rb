require "test_helper"

class ExpenditureTest < ActiveSupport::TestCase
  test "有効な収入データは保存できる" do
    expenditure = build(:income)
    assert expenditure.valid?
  end

  test "有効な将来の支出データは保存できる" do
    expenditure = build(:future_expense)
    assert expenditure.valid?
  end

  test "有効な固定費データは保存できる" do
    expenditure = build(:fixed_cost)
    assert expenditure.valid?
  end

  test "nameがない場合は無効" do
    expenditure = build(:income, name: "  ")
    assert_not expenditure.valid?
  end

  test "amountがない場合は無効" do
    expenditure = build(:income, amount: nil)
    assert_not expenditure.valid?
  end

  test "amountが0以下の場合は無効" do
    expenditure = build(:income, amount: 0)
    assert_not expenditure.valid?
  end

  test "amountが負の値の場合は無効" do
    expenditure = build(:income, amount: -100)
    assert_not expenditure.valid?
  end

  test "categoryがない場合は無効" do
    expenditure = build(:income, category: nil)
    assert_not expenditure.valid?
  end

  test "categoryがincomeの場合は有効" do
    expenditure = build(:income)
    assert expenditure.income?
  end

  test "categoryがfuture_expenseの場合は有効" do
    expenditure = build(:future_expense)
    assert expenditure.future_expense?
  end

  test "categoryがfixed_costの場合は有効" do
    expenditure = build(:fixed_cost)
    assert expenditure.fixed_cost?
  end
end
