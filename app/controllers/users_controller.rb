class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You registered! Welcome, #{params[:user][:username]}!"
      session[:user_id] = @user.id
      redirect_to posts_path
    else 
      render :new 
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    #binding.pry
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      flash[:notice] = "You updated your info, #{params[:user][:username]}!"
      session[:user_id] = @user.id
      redirect_to posts_path
    else 
      render :edit
    end
  end

  private 

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
