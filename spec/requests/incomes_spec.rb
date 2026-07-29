require "rails_helper"

RSpec.describe "Incomes", type: :request do
  let(:user) { create(:user) }
  let(:income) { create(:income, user: user) }

  before do
    sign_in user
  end

  describe "GET /incomes" do
    context "ログイン済みの場合" do
      it "一覧画面が表示される" do
        get incomes_path
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      before { sign_out user }
      it "ログイン画面にリダイレクトされる" do
        get incomes_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /incomes" do
    context "有効なデータの場合" do
      it "収入を登録できる" do
        expect {
          post incomes_path, params: { income: { name: "貯蓄", amount: 1000000 } }
        }.to change(Expenditure, :count).by(1)
        expect(response).to redirect_to incomes_path
      end
    end

    context "無効なデータの場合" do
      it "収入を登録できない" do
        expect {
          post incomes_path, params: { income: { name: "", amount: nil} }
        }.not_to change(Expenditure, :count)
      end
    end
  end
  
  describe "PATCH /incomes/:id" do
    context "有効なデータの場合" do
      it "収入を更新できる" do
        patch income_path(income), params: { income: { name: "退職金", amount: 2000000 } }
        expect(response).to redirect_to edit_all_incomes_path
        expect(income.reload.name).to eq "退職金"
      end
    end
  end

  describe "DELETE /incomes/:id" do
    context "有効なデータの場合" do
      it "収入を削除できる" do
        income
        expect { 
          delete income_path(income)
        }.to change(Expenditure, :count).by(-1)
        expect(response).to redirect_to edit_all_incomes_path
      end
    end
  end
end


