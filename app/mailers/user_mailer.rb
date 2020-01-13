class UserMailer < ApplicationMailer
  default from: 'shalu.chalana@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome from Lexington Nutrition Services')
  end
end