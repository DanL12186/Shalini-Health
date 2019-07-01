class SessionsController < ApplicationController

  def new
    redirect_if_logged_in
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])
    session[:user_id] = @user.id if @user && @user.authenticate(session_params[:password])

    if !!session[:user_id]
      redirect_to root_path
    else
      @user = User.new(email: session_params[:email])
      flash[:error] = "Username and password don't match"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:password, :email, :uid)
  end

end