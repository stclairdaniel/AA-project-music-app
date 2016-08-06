class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:session][:email], params[:session][:password])
    if @user
      login!(@user)
      flash[:notices] = ["Sucessfully logged in"]
      redirect_to bands_url
    else
      @user = User.new
      flash.now[:errors] = ["Incorrect credentials. Please try again."]
      render :new
    end
  end

  def destroy
    if current_user
      flash[:notices] = ["You have logged out."]
      logout
      redirect_to new_session_url
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
