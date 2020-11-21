class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    buckets_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :location, :birthday])
    devise_parameter_sanitizer.permit(:account_update,  keys: [:name, :location, :birthday, :email, :password, :current_password])
  end
end
