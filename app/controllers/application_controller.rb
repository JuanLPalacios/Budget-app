class ApplicationController < ActionController::Base
  before_action :config_params_sanitizer, if: :devise_controller?

  def config_params_sanitizer
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def index; end
end
