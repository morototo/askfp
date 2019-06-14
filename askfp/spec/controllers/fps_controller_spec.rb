require 'rails_helper'

RSpec.describe FpsController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #search' do
    context 'ログインしている：ゲスト' do
      before :each do
        sign_in @guest_user
      end
      it 'ゲスト：FP一覧画面にアクセス出来ること' do
        get :search
        expect(response).to render_template :search
      end
    end
    context 'ログインしている：FP' do
      before :each do
        sign_in @fp_user
      end
      it 'FP：FP一覧画面にアクセス出来ない' do
        get :search
        expect(response).not_to render_template :search
      end
    end
    context 'ログインしていない' do
      it 'FP一覧画面にアクセス出来ないこと' do
        get :search
        expect(response).not_to render_template :search
      end
    end
  end
end
