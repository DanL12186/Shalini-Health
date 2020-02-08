class UserMailer < ApplicationMailer
  default from: 'shalu.chalana@gmail.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome from Lexington Nutrition Services')
  end

  def appointment_email
    @user = params[:user]
    @appointment_date = params[:appointment_date]
    mail(to: @user.email, subject: "Your appointment with Lexington Nutrition Services")
  end
end