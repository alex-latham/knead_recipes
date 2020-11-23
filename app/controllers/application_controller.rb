class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:user_id] == 'guest'
      guest = Guest.new('Guest', 'Guest')
      @current_user ||= guest if session[:user_id] == 'guest'
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  def require_user
    render file: 'public/404', status: :not_found unless current_user
  end
end
