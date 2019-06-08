class ApplicationController < ActionController::Base
  include ReservationsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
  end
end
