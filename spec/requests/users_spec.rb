require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "PATCH /home/update_job_search" do
    context "ログイン済みの場合" do
      it "転職期間を設定できる" do
        patch update_job_search_path, params: {
          user: {
            job_search_start_month: "2026-07-01",
            job_search_end_month: "2026-10-01"
          }
        }
        expect(response).to redirect_to home_path
        user.reload
        expect(user.job_search_start_month).to eq Date.new(2026, 7, 1)
        expect(user.job_search_end_month).to eq Date.new(2026, 10, 1)
      end
    end
    
    context "未ログインの場合" do
      before { sign_out user }
      it "ログイン画面にリダイレクトされる" do
        patch update_job_search_path, params: {
          user: {
            job_search_start_month: "2026-07-01",
            job_search_end_month: "2026-10-01"
          }
         }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end



