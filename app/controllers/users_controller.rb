class UsersController < ApplicationController
  include TimeConversion

  def new
    redirect_if_logged_in
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    #incorporate this into initializer later
    cell = @user.cell.delete('- ')
    @user.cell = "#{cell[0..2]}-#{cell[3..5]}-#{cell[6..9]}"

    respond_to do | format |
      if @user.save
        session[:user_id] = @user.id

        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).welcome_email.deliver_later
 
        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    redirect_to user_path(current_user.id) if current_user.id != params[:id].to_i

    @future_appointments = current_user.appointments.select { | appt | appt.date.future? }.sort_by(&:date)
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :home_phone, :cell, :password, :email, :password_confirmation)
  end
end
