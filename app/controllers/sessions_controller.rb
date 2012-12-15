class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    
    if !user || !user.authenticate(params[:session][:password])
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    elsif !user.activated?
      flash[:error] = 'User is not activated.'
      redirect_to signin_url
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end
