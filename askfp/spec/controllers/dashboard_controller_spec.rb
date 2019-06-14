require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #index' do
    context 'ログインしている' do
      it 'ダッシュボード画面にアクセス出来ること' do
      end
    end
    context 'ログインしていない' do
      it 'ダッシュボード画面にアクセス出来ないこと' do
      end
    end
  end
end
