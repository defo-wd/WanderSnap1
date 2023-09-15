class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :profile_image])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :profile_image])
  end
end
