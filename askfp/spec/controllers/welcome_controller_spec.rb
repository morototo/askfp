require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #index' do
    context 'ログインしている' do
      it 'TOP画面が表示できる' do
      end
    end
    context 'ログインしていない' do
      it 'TOP画面が表示できる' do
      end
    end
  end
end
