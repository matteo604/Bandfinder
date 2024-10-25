class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :telephone_number, :instrument, :address, :leader, :status, :latitude, :longitude, :band_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :telephone_number, :instrument, :address, :leader, :status, :latitude, :longitude, :band_id])
  end
end
