class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate
    authenticate_with_http_basic do |name, password|
      name == CONFIG['admin_username'] && password == CONFIG['admin_password']
    end
  end

end
