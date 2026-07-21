require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @transaction = create(:expense_transaction, user: @user)
    sign_in @user
  end

  # 一覧画面のテスト
  test "ログイン済みの場合は一覧画面が表示される" do
    get transactions_url
    assert_response :success
  end

  test "未ログインの場合はログイン画面にリダイレクトされる" do
    sign_out @user
    get transactions_url
    assert_redirected_to new_user_session_path
  end

  # 登録のテスト
  test "有効なデータで随時支出を登録できる" do
    assert_difference("Transaction.count", 1) do
      post transactions_url, params: { transaction: { name: "外食", category: "expense", amount: 3000 } }
    end
    assert_redirected_to home_path
  end

  test "有効なデータで随時収入を登録できる" do
    assert_difference("Transaction.count", 1) do
      post transactions_url, params: { transaction: { name: "副業", category: "income", amount: 10000 } }
    end
    assert_redirected_to home_path
  end

  test "無効なデータでは登録できない" do
    assert_no_difference("Transaction.count") do
      post transactions_url, params: { transaction: { name: "", category: "expense", amount: nil } }
    end
  end

  # 削除のテスト
  test "随時支出を削除できる" do
    assert_difference("Transaction.count", -1) do
      delete transaction_url(@transaction)
    end
    assert_redirected_to transactions_path
  end
end
