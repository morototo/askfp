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
    let!(:valid_update_params) { { profile: FactoryBot.attributes_for(:profile, name: "CHANGE_TESTNAME", self_introduction: "CHANGE_TESTSELFINTRODUCTION"), id: @fp_user.profile.id } }
    context 'ログインしている' do
      before :each do
        sign_in @fp_user
      end
      it 'プロフィールが編集できる' do
        put :update, params: valid_update_params
        expect(assigns(:profile)).to eq @fp_user.profile
      end
    end
    context 'ログインしていない' do
      it 'プロフィールが編集出来ないこと' do
        put :update, params: valid_update_params
        expect(assigns(:profile)).not_to eq @fp_user.profile
      end
    end
  end
end
