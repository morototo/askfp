class FpsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_is_guest, only: [:search]
  def show
  end

  def search
    @fp_user = User.fp_user
  end
end
