class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.is_password?(params[:session][:password])
      login!(@user)
      redirect_to user_url(@user.id)
    else
      @user = User.new(email: params[:session][:email])
      flash.now[:errors] ||= []
      flash.now[:errors] << "Incorrect credentials. Please try again."
      render :new
    end
  end

  def destroy
    if current_user
      logout
      redirect_to new_sessions_url
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
