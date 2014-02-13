class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username]) #.where(content).first also works
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id
      flash[:notice] = "You've logged in! Welcome, #{user.username}!"
      redirect_to root_path
    else 
      flash[:error] = "Sorry, there was something wrong with your username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out! Thanks for stopping by!"
    redirect_to root_path
  end
end