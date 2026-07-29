require "rails_helper"

RSpec.describe "Fixed_costs", type: :request do
  let(:user) { create(:user) }
  let(:fixed_cost) { create(:fixed_cost, user: user) }

  before do
    sign_in user
  end

  describe "GET /fixed_costs" do
    context "ログイン済みの場合" do
      it "一覧画面が表示される" do
        get fixed_costs_path
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      before { sign_out user }
      it "ログイン画面にリダイレクトされる" do
        get fixed_costs_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /fixed_costs" do
    context "有効なデータの場合" do
      it "固定費を登録できる" do
        expect {
          post fixed_costs_path, params: { fixed_cost: { name: "家賃", amount: 100000 } }
        }.to change(Expenditure, :count).by(1)
        expect(response).to redirect_to fixed_costs_path
      end
    end

    context "無効なデータの場合" do
      it "固定費を登録できない" do
        expect {
          post fixed_costs_path, params: { fixed_cost: { name: "", amount: nil} }
        }.not_to change(Expenditure, :count)
      end
    end
  end
  
  describe "PATCH /fixed_costs/:id" do
    context "有効なデータの場合" do
      it "固定費を更新できる" do
        patch fixed_cost_path(fixed_cost), params: { fixed_cost: { name: "家賃", amount: 120000 } }
        expect(response).to redirect_to edit_all_fixed_costs_path
        expect(fixed_cost.reload.name).to eq "家賃"
      end
    end
  end

  describe "DELETE /fixed_costs/:id" do
    context "有効なデータの場合" do
      it "固定費を削除できる" do
        fixed_cost
        expect { 
          delete fixed_cost_path(fixed_cost)
        }.to change(Expenditure, :count).by(-1)
        expect(response).to redirect_to edit_all_fixed_costs_path
      end
    end
  end
end


