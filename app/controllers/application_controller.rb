class ApplicationController < ActionController::Base
  before_filter :load_user

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def login_required
    redirect_to(static_pages_index_path) unless session[:user]
  end

  protected
    def load_user
      if session[:user]
        @user = User.find session[:user]
      end
    end
end
