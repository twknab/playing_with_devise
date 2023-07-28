class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: 'You have successfully been logged in.'
    else
      flash.now.alert = "Email or password is invalid."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # session.delete(:user_id)
    p("IS THIS EVEN RUNNING?")
    session[:user_id] = nil
    flash.now.alert = "You have been successfully logged out."
    redirect_to root_url, notice: "Logged out!"
  end
end
