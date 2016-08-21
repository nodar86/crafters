class SessionsController < ApplicationController
  def create
    @current_user = User.authenticate(params[:username], params[:password])
    if @current_user
      session[:user] = @current_user.id
      flash[:success] = "Sikeres bejelentkezés"
      if params[:from]
        redirect_to params[:from]
      else
        redirect_to root_url
      end
    else
      flash[:danger] = "Hibás felhasználónév vagy jelszó"
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    reset_session
    flash[:success] = "Sikeres kijelentkezés"
    redirect_to static_pages_index_path
    @current_user = nil
  end
end
