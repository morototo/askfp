require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #show' do
    context 'ログインしている' do
      it '予約一覧画面が表示できる' do
      end
    end
    context 'ログインしていない' do
      it '予約一覧画面が表示できない' do
      end
    end
  end

  describe 'GET #index' do
    context 'ログインしている' do
      it '予約画面が表示できる' do
      end
    end
    context 'ログインしていない' do
      it '予約画面が表示できない' do
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしている' do
      it 'ゲスト: 予約が保存される' do
      end
      it 'FP: 予約が保存されない' do
      end
      it '予約日時がFPの予約不可時間: 予約が保存されない' do
      end
      it '予約日時が平日の時間外（10:00~18:00以外）: 予約が保存されない' do
      end
      it '予約日時が土日の時間外（11:00~15:00）: 予約が保存されない' do
      end
      it '予約日時が日曜: 予約が保存されない' do
      end
      it '予約日時が既に埋まっている: 予約が保存されない' do
      end
    end
    context 'ログインしていない' do
      it '予約ができない' do
      end
    end
  end
end
