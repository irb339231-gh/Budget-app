require "test_helper"

class FixedCostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @fixed_cost = create(:fixed_cost, user: @user)
    sign_in @user
  end

  # 一覧画面のテスト
  test "ログイン済みの場合は一覧画面が表示される" do
    get fixed_costs_url
    assert_response :success
  end

  test "未ログインの場合はログイン画面にリダイレクトされる" do
    sign_out @user
    get fixed_costs_url
    assert_redirected_to new_user_session_path
  end

  # 登録のテスト
  test "有効なデータで固定費を登録できる" do
    assert_difference("Expenditure.count", 1) do
      post fixed_costs_url, params: { fixed_cost: { name: "家賃", amount: 100000 } }
    end
    assert_redirected_to fixed_costs_path
  end

  test "無効なデータでは固定費を登録できない" do
    assert_no_difference("Expenditure.count") do
      post fixed_costs_url, params: { fixed_cost: { name: "", amount: nil } }
    end
  end

  # 更新のテスト
  test "有効なデータで固定費を更新できる" do
    patch fixed_cost_url(@fixed_cost), params: { fixed_cost: { name: "家賃", amount: 120000 } }
    assert_redirected_to edit_all_fixed_costs_path
    @fixed_cost.reload
    assert_equal "家賃", @fixed_cost.name
  end

  # 削除のテスト
  test "固定費を削除できる" do
    assert_difference("Expenditure.count", -1) do
      delete fixed_cost_url(@fixed_cost)
    end
    assert_redirected_to edit_all_fixed_costs_path
  end
end

