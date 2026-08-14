require 'rails_helper'

RSpec.describe "Wizards", type: :request do
  let(:user) { create(:user)}

  before do
    sign_in user
  end

  describe "GET /wizard/step1" do
    context "ログイン済みの場合" do
      it "step1の画面が表示される" do
        get wizard_path(:step1)
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      before { sign_out user}
      it "ログイン画面にリダイレクトされる" do
        get wizard_path(:step1)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET /wizard/step2" do
    it "step2の画面が表示される" do
      get wizard_path(:step2)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /wizard/step3" do
    it "step2の画面が表示される" do
      get wizard_path(:step3)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /wizard/step4" do
    it "step2の画面が表示される" do
      get wizard_path(:step4)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /wizard/step1" do
    it "転職期間を設定できる" do
      patch wizard_path(:step1), params: {
        user: {
          job_search_start_month: "2026-07-01",
          job_search_end_month: "2026-10-01"
        }
      } 
      expect(response).to redirect_to wizard_path(:step2)
      
    end
  end

  describe "PATCH /wizard/step2" do
    context "有効なデータの場合" do
      it "収入を登録できる" do
        expect {
          patch wizard_path(:step2), params: {
            income: { name: "貯蓄", amount: 1000000 }
          }
        }.to change(Expenditure, :count).by(1)
        expect(response).to redirect_to wizard_path(:step2)
      end
    end

    context "無効なデータの場合" do
      it "収入を登録できない" do
        expect {
          patch wizard_path(:step2), params: {
            income: { name: "", amount: nil }
          }
        }.not_to change(Expenditure, :count)
      end
    end
  end

  describe "PATCH /wizard/step3" do
    context "有効なデータの場合" do
      it "支出を登録できる" do
        expect {
          patch wizard_path(:step3), params: {
            future_expense: { name: "引っ越し", amount: 50000 }
          }
        }.to change(Expenditure, :count).by(1)
        expect(response).to redirect_to wizard_path(:step3)
      end
    end
  end

  describe "PATCH /wizard/step4" do
    context "有効なデータの場合" do
      it "固定費を登録できる" do
        expect {
          patch wizard_path(:step4), params: {
            fixed_cost: { name: "ローン", amount: 20000 }
          }
        }.to change(Expenditure, :count).by(1)
        expect(response).to redirect_to wizard_path(:step4)
      end
    end
  end
end


        



