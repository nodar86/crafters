class UsersController < ApplicationController

  def whitelist_show
  end

  def whitelist_apply
    if @user
      unless @user.isonwhitelist
        wl_file = "/home/minecraft/spigot/whitelist.json"
        if wl_file
          wl_hash = JSON.parse(File.read(wl_file))
          wl_hash << { name: @user.username, uuid: "" }
          file = File.open(wl_file, "w")
          file.write(JSON.pretty_generate(wl_hash))
          file.close
          @user.isonwhitelist = true
          @user.save
          flash[:success] = "Sikeres jelentkezés, próbálj belépni a crafters.no-ip.org címen!"
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
    @user.attributes = params_user
    if @user.email_changed?
      @user.email_confirmed = false
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
end
