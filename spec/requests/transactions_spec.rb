require "rails_helper"

RSpec.describe "Transactions", type: :request do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  before do
    sign_in user
  end

  describe "GET /transactions" do
    context "ログイン済みの場合" do
      it "一覧画面が表示される" do
        get transactions_path
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      before { sign_out user }
      it "ログイン画面にリダイレクトされる" do
        get transactions_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /transactions" do
    context "有効なデータの場合" do
      it "随時支出を登録できる" do
        expect {
          post transactions_path, params: { transaction: { name: "外食", category: "expense", amount: 3000 } }
        }.to change(Transaction, :count).by(1)
        expect(response).to redirect_to home_path
      end

      it "随時収入を登録できる" do
        expect {
          post transactions_path, params: { transaction: { name: "副業", category: "income", amount: 10000 } }
        }.to change(Transaction, :count).by(1)
        expect(response).to redirect_to home_path
      end
    end

    context "無効なデータの場合" do
      it "随時支出を登録できない" do
        expect {
          post transactions_path, params: { transaction: { name: "", category: "expense", amount: nil } }
        }.not_to change(Transaction, :count)
      end
    end
  end

  describe "DELETE /transactions/:id" do
    context "有効なデータの場合" do
      it "随時支出を削除できる" do
        transaction
        expect {
          delete transaction_path(transaction)
        }.to change(Transaction, :count).by(-1)
        expect(response).to redirect_to transactions_path
      end
    end
  end
end
