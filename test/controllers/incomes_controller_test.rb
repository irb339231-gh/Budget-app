require "test_helper"

class IncomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @income = create(:income, user: @user)
    sign_in @user
  end

  # 一覧画面のテスト
  test "ログイン済みの場合は一覧画面が表示される" do
    get incomes_url
    assert_response :success
  end

  test "未ログインの場合はログイン画面にリダイレクトされる" do
    sign_out @user
    get incomes_url
    assert_redirected_to new_user_session_path
  end

  # 登録のテスト
  test "有効なデータで収入を登録できる" do
    assert_difference("Expenditure.count", 1) do
      post incomes_url, params: { income: { name: "貯蓄", amount: 1000000 } }
    end
    assert_redirected_to incomes_path
  end

  test "無効なデータでは収入を登録できない" do
    assert_no_difference("Expenditure.count") do
      post incomes_url, params: { income: { name: "", amount: nil } }
    end
  end

  # 更新のテスト
  test "有効なデータで収入を更新できる" do
    patch income_url(@income), params: { income: { name: "退職金", amount: 2000000 } }
    assert_redirected_to edit_all_incomes_path
    @income.reload
    assert_equal "退職金", @income.name
  end

  # 削除のテスト
  test "収入を削除できる" do
    assert_difference("Expenditure.count", -1) do
      delete income_url(@income)
    end
    assert_redirected_to edit_all_incomes_path
  end
end
