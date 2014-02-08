class PostsController < ApplicationController
  #rails 3: before_filter
  #use before_action for instance variables, redirect on condition
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first #TODO: change once we learn authentication
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else 
      render :new 
    end

  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "You updated your post"
      redirect_to posts_path
    else
      render :edit 
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end

# create method notes
    # Pass in from html
    # Post.create(params[:title], params[:url], params[:description])

    # Pass in from basic rails form
    # Post.create(title: params[:title], url: params[:url], description: 
    #   params[:description], user_id: 1)

    # e.g. title is a setter method from ActiveRecord pattern

    # Model-backed form, Rails 3
    # Post.create(params[:post]) #mass assignment because post is a hash
  
    # Mass assignment security - Rails 3 had attr_accessible in post.rb,
    # whitelist things, eventually you wind up whitelisting everything
    # post = Post.new(params[:post])
    # Rails 4, strong parameters


# Post params notes
    # best practices around strong params still emerging
    # non-permitted stuff gets wiped, source of silent bugs, blah, but important
    # to not let potential hackers know what's going on
    # params.require(:post).permit(:title, :url, :description, :creator)
    # params.require(:post).permit! # Allow everything
    #if user.admin?
    #  permit!
    #else
    #  permit (:title, :url, :description, :creator)
