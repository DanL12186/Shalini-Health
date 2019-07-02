class UserMailer < ApplicationMailer
  default from: 'shalani@shalani-health.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome from ActionMailer 5.2')
  end
end
