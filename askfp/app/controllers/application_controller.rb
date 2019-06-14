class ApplicationController < ActionController::Base
  include ReservationsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
  end

  def check_is_guest
    redirect_to root_path unless current_user.is_guest?
  end

  def check_is_fp
    redirect_to root_path unless current_user.is_fp?
  end
end
