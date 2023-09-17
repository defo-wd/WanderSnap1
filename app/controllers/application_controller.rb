class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_search

  def initialize_search
    @q_user = User.ransack(params[:q_user])
    @q_post = Post.ransack(params[:q_post])
    @q_map = Map.ransack(params[:q_map])
  end

  def search
    @results_user = @q_user.result(distinct: true) if params[:q_user].present?
    @results_post = @q_post.result(distinct: true) if params[:q_post].present?
    @results_map = @q_map.result(distinct: true) if params[:q_map].present?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :profile_image])
  end
end
