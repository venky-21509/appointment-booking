class UserMailer < ApplicationMailer


  def welcome_email
   @user = params[:user]
   
   mail(to: "venkeypothem21@gmail.com",
             subject: "Welcome to my application")
  end
end
