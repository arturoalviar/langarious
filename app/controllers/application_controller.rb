class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  #permit additional parameters the lazy way; directly from devise docs
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def render_404
    render file: 'public/404.html', status: :not_found
  end

  def render_error
    render file: 'public/500.html', status: :internal_server_error
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
