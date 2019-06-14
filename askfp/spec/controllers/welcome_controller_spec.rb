require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #index' do
    context 'ログインしている' do
      before :each do
        sign_in @fp_user
      end
      it 'TOP画面が表示できる' do
        get :index
        expect(response).to render_template :index
      end
    end
    context 'ログインしていない' do
      it 'TOP画面が表示できる' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
