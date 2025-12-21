class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_customer!, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    appointments_path
  end
end
