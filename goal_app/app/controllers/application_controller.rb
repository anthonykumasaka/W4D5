class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def logout
    session[:session_token] = nil
    current_user.session_token = reset_session_token!
  end
  
  def require_signed_in
    redirect_to new_session_url unless signed_in?
  end
  
  def signed_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def login!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end
end
