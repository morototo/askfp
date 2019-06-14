require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #edit' do
    context 'ログインしている' do
      it 'プロフィール編集画面にアクセス出来ること' do
      end
    end
    context 'ログインしていない' do
      it 'プロフィール編集画面にアクセス出来ないこと' do
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしている' do
      it 'プロフィールが編集できる' do
      end
      it 'パラメータエラー: name' do
      end
      it 'パラメータエラー: self_introduction' do
      end
    end
    context 'ログインしていない' do
      it 'プロフィールが編集出来ないこと' do
      end
    end
  end
end
