require "rails_helper"

RSpec.describe "Future_expenses", type: :request do
  let(:user) { create(:user) }
  let(:future_expense) { create(:future_expense, user: user) }

  before do
    sign_in user
  end

  describe "GET /future_expenses" do
    context "ログイン済みの場合" do
      it "一覧画面が表示される" do
        get future_expenses_path
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      before { sign_out user }
      it "ログイン画面にリダイレクトされる" do
        get future_expenses_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /future_expenses" do
    context "有効なデータの場合" do
      it "支出を登録できる" do
        expect {
          post future_expenses_path, params: { future_expense: { name: "旅行", amount: 50000 } }
        }.to change(Expenditure, :count).by(1)
        expect(response).to redirect_to future_expenses_path
      end
    end

    context "無効なデータの場合" do
      it "支出を登録できない" do
        expect {
          post future_expenses_path, params: { future_expense: { name: "", amount: nil } }
        }.not_to change(Expenditure, :count)
      end
    end
  end

  describe "PATCH /future_expenses/:id" do
    context "有効なデータの場合" do
      it "支出を更新できる" do
        patch future_expense_path(future_expense), params: { future_expense: { name: "旅行", amount: 60000 } }
        expect(response).to redirect_to edit_all_future_expenses_path
        expect(future_expense.reload.name).to eq "旅行"
      end
    end
  end

  describe "DELETE /future_expenses/:id" do
    context "有効なデータの場合" do
      it "支出を削除できる" do
        future_expense
        expect {
          delete future_expense_path(future_expense)
        }.to change(Expenditure, :count).by(-1)
        expect(response).to redirect_to edit_all_future_expenses_path
      end
    end
  end
end
