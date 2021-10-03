class SessionsController < ApplicationController
  def new
    if session[:user_id]
      #すでにログインしています
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
