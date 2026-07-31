class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.job_search_start_month.nil?
      wizard_path(:step1)
    else
      stored_location_for(resource) || home_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
