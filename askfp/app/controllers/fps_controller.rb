class FpsController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def search
    @fp_user = User.fp_user
  end
end
