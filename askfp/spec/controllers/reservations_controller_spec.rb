require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #new' do
    context 'ログインしている: ゲスト' do
      before :each do
        sign_in @guest_user
      end
      it '予約一覧画面が表示できる' do
        get :new
        expect(response).to render_template :new
      end
    end
    context 'ログインしている: FP' do
      before :each do
        sign_in @fp_user
      end
      it '予約一覧画面が表示できない' do
        get :new
        expect(response).not_to render_template :new
      end
    end
    context 'ログインしていない' do
      it '予約一覧画面が表示できない' do
        get :new
        expect(response).not_to render_template :new
      end
    end
  end

  describe 'GET #index' do
    context 'ログインしている' do
      before :each do
        sign_in @guest_user
      end
      it '予約画面が表示できる' do
        get :index
        expect(response).to render_template :index
      end
    end
    context 'ログインしていない' do
      it '予約画面が表示できない' do
        get :index
        expect(response).not_to render_template :index
      end
    end
  end

  describe 'POST #create' do
    let!(:valid_create_params) { { reservation: FactoryBot.attributes_for(:reservation, fp_id: , guest_id: @guest_user.id, reservation_date: start_at: "12:00" ) } }
    context 'ログインしている' do
      before :each do
        sign_in @guest_user
      end
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
