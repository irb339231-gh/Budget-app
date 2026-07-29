require "rails_helper"

RSpec.describe "Home", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /home" do
    context "ログイン済みの場合" do
      it "一覧画面が表示される" do
        get home_path
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      before { sign_out user }
      it "ログイン画面にリダイレクトされる" do
        get home_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
