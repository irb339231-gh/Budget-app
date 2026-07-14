require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in @user
  end

  test "should get index" do
    get home_url
    assert_response :success
  end
end
