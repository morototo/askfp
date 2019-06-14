class FpsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_type, only: [:search]
  def show
  end

  def search
    @fp_user = User.fp_user
  end

  private
  def check_user_type
    redirect_to root_path if current_user.is_fp?
  end
end
