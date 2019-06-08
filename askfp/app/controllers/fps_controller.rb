class FpsController < ApplicationController
  def show
  end

  def search
    @fp_user = User.fp_user
  end
end
