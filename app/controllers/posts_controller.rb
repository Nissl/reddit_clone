class PostsController < ApplicationController
  def index
    @posts = Post.all
    render 'posts/index' #default, unnecessary
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end
end
