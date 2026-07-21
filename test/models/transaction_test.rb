require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # バリデーションのテスト
  test "有効な支出データは保存できる" do
    transaction = build(:expense_transaction)
    assert transaction.valid?
  end

  test "有効な収入データは保存できる" do
    transaction = build(:income_transaction)
    assert transaction.valid?
  end

  test "amountがない場合は無効" do
    transaction = build(:expense_transaction, amount: nil)
    assert_not transaction.valid?
  end

  test "amountが0以下の場合は無効" do
    transaction = build(:expense_transaction, amount: 0)
    assert_not transaction.valid?
  end

  test "amountが負の値の場合は無効" do
    transaction = build(:expense_transaction, amount: -100)
    assert_not transaction.valid?
  end

  test "categoryがない場合は無効" do
    transaction = build(:expense_transaction, category: nil)
    assert_not transaction.valid?
  end

  # enumのテスト
  test "categoryがexpenseの場合は有効" do
    transaction = build(:expense_transaction)
    assert transaction.expense?
  end

  test "categoryがincomeの場合は有効" do
    transaction = build(:income_transaction)
    assert transaction.income?
  end
end
