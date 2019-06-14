require 'rails_helper'

RSpec.describe FpsController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #search' do
    context 'ログインしている' do
      it 'FP一覧画面にアクセス出来ること' do
      end
    end
    context 'ログインしていない' do
      it 'FP一覧画面にアクセス出来ること' do
      end
    end
  end
end
