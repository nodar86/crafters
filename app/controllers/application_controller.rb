class ApplicationController < ActionController::Base
  before_action :load_user

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def login_required
    redirect_to(static_pages_index_path) unless session[:user]
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
      end
    end
end
