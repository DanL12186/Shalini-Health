class ShalaniMailer < ApplicationMailer
    default from: 'lexingtonnutritionservices.com'

    def appointment_email
      @user = params[:user]
      @appointment_date = params[:appointment_date]
      mail(to: 'daniel.lempesis@gmail.com', subject: "New appointment for #{@user.first_name} #{@user.last_name}")
    end
  end