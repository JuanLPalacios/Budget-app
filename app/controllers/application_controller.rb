class ApplicationController < ActionController::Base
  before_action :config_params_sanitizer, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    groups_path
  end

  def config_params_sanitizer
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def index; end
end
