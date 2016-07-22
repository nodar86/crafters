class UserMailer < ActionMailer::Base
  default :from => "craftersmain@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Regisztráció megerősítése")
  end
end
