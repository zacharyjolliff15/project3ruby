class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      reset_session
      session[:user_id] = user.id
      redirect_to posts_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out."
  end
end
