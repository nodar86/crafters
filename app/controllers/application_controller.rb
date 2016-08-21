class ApplicationController < ActionController::Base
  before_action :load_user

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def login_required(custom_from = nil)
    unless session[:user]
      flash[:danger] = "A kívánt oldal megtekintéséhez bejelentkezés szükséges!"
      redirect_to static_pages_login_path(from: custom_from || request.fullpath)
    end
  end

  def admin_required
    if session[:user]
      unless User.find(session[:user]).isadmin
        redirect_to(static_pages_index_path)
      end
    else
      redirect_to(static_pages_index_path)
    end
  end

  protected
    def load_user
      if session[:user]
        @current_user = User.find session[:user]
        @current_user.online_at = Time.now
        @current_user.save!
      end
    end
end
