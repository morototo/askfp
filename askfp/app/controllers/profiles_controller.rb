class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(update_params)
        format.html { redirect_to dashboard_index_path, notice: 'プロフィールを変更しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_profile
      @profile = current_user.profile
    end

    def update_params
      params.require(:profile).permit(:name, :self_introduction)
    end
end
