require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in @user
  end

  # 転職活動期間設定のテスト
  test "転職活動期間を設定できる" do
    patch update_job_search_path, params: {
      user: {
        job_search_start_month: "2026-07-01",
        job_search_end_month: "2026-10-01"
      }
    }
    assert_redirected_to home_path
    @user.reload
    assert_equal Date.new(2026, 7, 1), @user.job_search_start_month
    assert_equal Date.new(2026, 10, 1), @user.job_search_end_month
  end

  test "未ログインの場合はログイン画面にリダイレクトされる" do
    sign_out @user
    patch update_job_search_path, params: {
      user: {
        job_search_start_month: "2026-07-01",
        job_search_end_month: "2026-10-01"
      }
    }
    assert_redirected_to new_user_session_path
  end
end
