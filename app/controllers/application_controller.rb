class ApplicationController < ActionController::Base
  before_action :config_params_sanitizer, if: :devise_controller?
  before_action :authenticate_user!

  private

  def authenticate_user!
    return super if user_signed_in? || devise_controller?

    redirect_to root_path, notice: 'Please Login first!'
  end

  def after_sign_in_path_for(_resource)
    flash.clear
    groups_path
  end

  def config_params_sanitizer
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
