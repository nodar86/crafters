class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      @current_user = @user
      session[:user] = @user.id
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Kérlek erősítsd meg az email címed"
      redirect_to static_pages_index_path
    else
      flash[:danger] = "Hiba történt!"
      render :new
      return
    end
  end

  def update
    @user = User.update(params_user)
  end

  def destroy
  end

  def edit
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:token])
    if @user
      @user.email_activate
      flash[:success] = "Email sikeresen aktiválva"
      redirect_to root_url
    else
      flash[:danger] = "Nincs ilyen felhasználó"
      redirect_to root_url
    end
  end

  def confirm_email_resend
    @user = User.find_by_id(params[:id])
    if @user
      @user.generate_new_token
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Email újraküldve"
      redirect_to root_url
    else
      flash[:danger] = "Nincs ilyen felhasználó"
      redirect_to root_url
    end
  end

  private
    def params_user
      params.require(:user).permit([:email, :username, :birthdate, :password, :password_confirmation])
    end
end
