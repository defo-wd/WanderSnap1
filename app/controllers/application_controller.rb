class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # ユーザー登録時に必要な情報を許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end
end
