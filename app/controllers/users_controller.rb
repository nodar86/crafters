class UsersController < ApplicationController
  before_action :login_required, only: [:index, :edit, :update, :show]
  before_action :correct_user_required, only: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def whitelist_show
  end

  def whitelist_apply
    if @current_user
      unless @current_user.isonwhitelist
        wl_file = "/home/minecraft/spigot/whitelist.json"
        if wl_file
          wl_hash = JSON.parse(File.read(wl_file))
          wl_hash << { name: @current_user.username, uuid: "" }
          file = File.open(wl_file, "w")
          file.write(JSON.pretty_generate(wl_hash))
          file.close
          @current_user.isonwhitelist = true
          @current_user.save
          flash[:success] = "Sikeres jelentkezés, próbálj belépni az mc.craftershun.hu címen!"
        else
          flash[:danger] = "Hiba történt, nem olvasható a whitelist file, kérlek jelezd egy adminnak!"
        end
        redirect_to root_url
      else
        flash[:warning] = "Hiba történt, már rajta vagy a whitelisten"
        redirect_to root_url
      end
    else
      flash[:danger] = "Hiba történt, nem ismert felhasználó"
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      @current_user = @user
      session[:user] = @user.id
      UserMailer.registration_confirmation(@user).deliver
      flash[:info] = "Kérlek erősítsd meg az email címed"
      redirect_to static_pages_index_path
    else
      flash[:danger] = "Hiba történt!"
      render :new
      return
    end
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = params_user
    if @user.email_changed?
      @user.email_confirmed = false
      @user.confirm_token = SecureRandom.urlsafe_base64.to_s
      UserMailer.registration_confirmation(@user).deliver
    end
    if @user.save
      flash[:success] = "Sikeres adatmódosítás"
      redirect_to show_user_path
    else
      flash[:danger] = "Hiba történt"
      render :show
    end
  end

  def destroy
  end

  def edit
    @user = User.find params[:id]
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
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Email újraküldve"
      redirect_back(fallback_location: root_url)
    else
      flash[:danger] = "Nincs ilyen felhasználó"
      redirect_back(fallback_location: root_url)
    end
  end

  private
    def params_user
      params.require(:user).permit([:email, :username, :birthdate, :password, :password_confirmation])
    end
    
    def correct_user_required
      @user = User.find params[:id]
      redirect_to(root_url) unless @user == @current_user
    end
end
