require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  before :each do
    @fp_user    = FactoryBot.create(:user, :fp)
    @guest_user = FactoryBot.create(:user, :guest)
  end

  describe 'GET #edit' do
    context 'ログインしている' do
      before :each do
        sign_in @fp_user
      end
      it 'プロフィール編集画面にアクセス出来ること' do
        get :edit, params: {id: @fp_user.profile.id}
        expect(response).to render_template :edit
      end
    end
    context 'ログインしていない' do
      it 'プロフィール編集画面にアクセス出来ないこと' do
        get :edit, params: {id: @fp_user.profile.id}
        expect(response).not_to render_template :edit
      end
    end
  end

  describe 'POST #update' do
    let!(:valid_update_params) { { profile: FactoryBot.attributes_for(:profile, name: "CHANGE_TESTNAME"), id: @fp_user.profile.id } }
    context 'ログインしている' do
      before :each do
        sign_in @fp_user
      end
      it 'プロフィールが編集できる' do
        put :update, params: valid_update_params
        @fp_user.reload
        expect(@fp_user.profile.name).to eq "CHANGE_TESTNAME"
      end
    end
    context 'ログインしていない' do
      it 'プロフィールが編集出来ないこと' do
        put :update, params: valid_update_params
        @fp_user.reload
        expect(@fp_user.profile.name).not_to eq "CHANGE_TESTNAME"
      end
    end
  end
end
