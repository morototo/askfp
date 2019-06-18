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

  describe 'GET #show' do
    context 'ログインしている' do
      before :each do
        sign_in @guest_user
      end
      it '予約画面が表示できる' do
        get :show, params: {id: @guest_user.profile.id}
        expect(response).to render_template :show
      end
    end
    context 'ログインしていない' do
      it '予約画面が表示できない' do
        get :show, params: {id: @guest_user.profile.id}
        expect(response).not_to render_template :show
      end
    end
  end

  describe 'POST #create' do
    let!(:valid_create_params) { { reservation: FactoryBot.attributes_for(:reservation,
      fp_id: @fp_user.id, guest_id: @guest_user.id, reservation_date: Time.now.tomorrow.sunday? ? Time.now.yesterday : Time.now.tomorrow, start_at: "12:00" ) } }
    context 'ログインしている: ホスト' do
      before :each do
        sign_in @fp_user
      end
      it 'FP: 予約が保存されない' do
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
    end
    context 'ログインしている: ゲスト' do
      before :each do
        sign_in @guest_user
        @fp_user.fp_ng_time_frames.find_by(time_frame_id: TimeFrame.find_by(start_at: "10:00")).update(is_weekday: true)
      end
      it '予約が保存される' do
        expect {
          post :create, params: valid_create_params
        }.to change(Reservation, :count).by(1)
      end
      it '予約日時がFPの予約不可時間: 予約が保存されない' do
        valid_already_reserved_create_params = valid_create_params
        valid_already_reserved_create_params[:reservation][:start_at] = "10:00"
        expect {
          post :create, params: valid_already_reserved_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が平日の時間外（10:00~18:00以外）: 予約が保存されない : 9:00の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.now.tomorrow.sunday? ? Time.now.since(2.days) : Time.now.tomorrow
        targer_time = targer_time.saturday? ? targer_time.yesterday : targer_time
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "09:00"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が平日の時間外（10:00~18:00以外）: 予約が保存されない : 18:00の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.now.tomorrow.sunday? ? Time.now.since(2.days) : Time.now.tomorrow
        targer_time = targer_time.saturday? ? targer_time.yesterday : targer_time
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "18:00"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が平日の時間外（10:00~18:00以外）: 予約が保存されない : 09:45の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.now.tomorrow.sunday? ? Time.now.since(2.days) : Time.now.tomorrow
        targer_time = targer_time.saturday? ? targer_time.yesterday : targer_time
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "18:00"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が平日の時間外（10:00~18:00以外）: 予約が保存されない : 17:45の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.now.tomorrow.sunday? ? Time.now.since(2.days) : Time.now.tomorrow
        targer_time = targer_time.saturday? ? targer_time.yesterday : targer_time
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "18:00"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が土日の時間外（11:00~15:00以外）: 予約が保存されない : 10:00の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.parse("2100/01/02") #土曜日
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "10:00"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が土日の時間外（11:00~15:00以外）: 予約が保存されない : 15:00の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.parse("2100/01/02") #土曜日
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "15:00"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が土日の時間外（11:00~15:00以外）: 予約が保存されない : 10:45の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.parse("2100/01/02") #土曜日
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "10:45"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が土日の時間外（11:00~15:00以外）: 予約が保存されない : 14:45の場合' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.parse("2100/01/02") #土曜日
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "14:45"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が日曜: 予約が保存されない' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.parse("2100/01/03") #日曜日
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "10:00"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
      it '予約日時が既に埋まっている: 予約が保存されない' do
        valid_already_reserved_create_params = valid_create_params
        targer_time = Time.now.tomorrow.sunday? ? Time.now.since(2.days) : Time.now.tomorrow
        targer_time = targer_time.saturday? ? targer_time.yesterday : targer_time
        FactoryBot.create(:reservation, :set_reserved_day, :set_start_at, fp: @fp_user, guest: @guest_user, r_date: targer_time)
        valid_already_reserved_create_params[:reservation][:reservation_date] = targer_time
        valid_already_reserved_create_params[:reservation][:start_at] = "12:30"
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
    end
    context 'ログインしていない' do
      it '予約ができない' do
        expect {
          post :create, params: valid_create_params
        }.not_to change(Reservation, :count)
      end
    end
  end
end
