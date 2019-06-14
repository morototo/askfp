require 'rails_helper'

RSpec.describe FpNgTimeFramesController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #index' do
    context 'ログインしている' do
      it '予約不可時間設定画面が表示できる：FP' do
      end
      it '予約不可時間設定画面が表示できない：ゲスト' do
      end
    end
    context 'ログインしていない' do
      it '予約不可時間設定画面が表示できない' do
      end
    end
  end

  describe 'GET #create' do
    context 'ログインしている' do
      it '予約不可時間を登録できる：FP' do
      end
      it '予約不可時間を登録できない：ゲスト' do
      end
      it 'パラメータエラー：id' do
      end
      it 'パラメータエラー：user_id' do
      end
      it 'パラメータエラー：is_weekday' do
      end
      it 'パラメータエラー：is_holiday' do
      end
      it 'パラメータエラー：time_frame_id' do
      end
    end
    context 'ログインしていない' do
      it '予約不可時間設定画面が登録できない' do
      end
    end
  end
end
