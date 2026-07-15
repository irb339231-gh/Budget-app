require "test_helper"

class FutureExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @future_expense = create(:future_expense, user: @user)
    sign_in @user
  end

  # 一覧画面のテスト
  test "ログイン済みの場合は一覧画面が表示される" do
    get future_expenses_url
    assert_response :success
  end

  test "未ログインの場合はログイン画面にリダイレクトされる" do
    sign_out @user
    get future_expenses_url
    assert_redirected_to new_user_session_path
  end

  # 登録のテスト
  test "有効なデータで将来の支出を登録できる" do
    assert_difference("Expenditure.count", 1) do
      post future_expenses_url, params: { future_expense: { name: "旅行", amount: 50000 } }
    end
    assert_redirected_to future_expenses_path
  end

  test "無効なデータでは将来の支出を登録できない" do
    assert_no_difference("Expenditure.count") do
      post future_expenses_url, params: { future_expense: { name: "", amount: nil } }
    end
  end

  # 更新のテスト
  test "有効なデータで将来の支出を更新できる" do
    patch future_expense_url(@future_expense), params: { future_expense: { name: "旅行", amount: 60000 } }
    assert_redirected_to edit_all_future_expenses_path
    @future_expense.reload
    assert_equal "旅行", @future_expense.name
  end

  # 削除のテスト
  test "将来の支出を削除できる" do
    assert_difference("Expenditure.count", -1) do
      delete future_expense_url(@future_expense)
    end
    assert_redirected_to edit_all_future_expenses_path
  end
end
