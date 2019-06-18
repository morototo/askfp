require 'rails_helper'

RSpec.describe FpNgTimeFramesController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
    @target_time_frame = FpNgTimeFrame.find_by(time_frame_id: TimeFrame.first.id)
  end

  describe 'GET #index' do
    context 'ログインしている: ゲスト' do
      before :each do
        sign_in @guest_user
      end
      it '予約不可時間設定画面が表示できない：ゲスト' do
        get :index
        expect(response).not_to render_template :index
      end
    end
    context 'ログインしている: FP' do
      before :each do
        sign_in @fp_user
      end
      it '予約不可時間設定画面が表示できる' do
        get :index
        expect(response).to render_template :index
      end
    end
    context 'ログインしていない' do
      it '予約不可時間設定画面が表示できない' do
        get :index
        expect(response).not_to render_template :index
      end
    end
  end

  describe 'GET #create' do
    let!(:valid_create_params) { { :fp_ng_time_frames => { 
      1 => { :id => @target_time_frame.id, :user_id => @fp_user.id, :is_weekday => true, :is_holiday => true, :time_frame_id => @target_time_frame.time_frame_id }} } }
    context 'ログインしている: ゲスト' do
      before :each do
        sign_in @guest_user
      end
      it '予約不可時間を登録できない' do
        post :create, params: valid_create_params
        @target_time_frame.reload
        expect(@target_time_frame.is_weekday).not_to eq true
        expect(@target_time_frame.is_holiday).not_to eq true
      end
    end
    context 'ログインしている: FP' do
      before :each do
        sign_in @fp_user
      end
      it '予約不可時間を登録できる' do
        post :create, params: valid_create_params
        @target_time_frame.reload
        expect(@target_time_frame.is_weekday).to eq true
        expect(@target_time_frame.is_holiday).to eq true
      end
    end
    context 'ログインしていない' do
      it '予約不可時間設定画面が登録できない' do
        post :create, params: valid_create_params
        @target_time_frame.reload
        expect(@target_time_frame.is_weekday).not_to eq true
        expect(@target_time_frame.is_holiday).not_to eq true
      end
    end
  end
end
