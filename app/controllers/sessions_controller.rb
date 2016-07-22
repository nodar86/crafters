class SessionsController < ApplicationController
  def create
    @current_user = User.authenticate(params[:username], params[:password])
    if @current_user
      session[:user] = @current_user.id
      redirect_to :back
    else
      flash[:danger] = "Hibás felhasználónév vagy jelszó"
      redirect_to :back
    end
  end

  def destroy
    reset_session
    #flash[:success] = "Sikeres kijelentkezés"
    redirect_to static_pages_index_path
    @current_user = nil
  end
end
