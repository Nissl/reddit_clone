class PostsController < ApplicationController
  #rails 3: before_filter
  #use before_action for instance variables, redirect on condition
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
    # render 'posts/index' # default, unnecessary
  end

  def show
    @comment = Comment.new

    # render :show or 'posts/show'
  end

  def new
    @post = Post.new
  end

  def create
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

    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else # validation error
      render :new # render, don't redirect, so have instance variable access
                  # will reload contents, show errors (as directed by forms)
                  # will add field_with_errors div class to affected fields
                  # *automatically* (baked-in rails feature - just put a CSS
                  # style on it)
    end

  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "You updated your post"
      redirect_to posts_path
    else
      render :edit #can also use string
    end
  end

  private

  def post_params
    params.require(:post).permit!
    # best practices around strong params still emerging
    # non-permitted stuff gets wiped, source of silent bugs, blah, but important
    # to not let potential hackers know what's going on
    # params.require(:post).permit(:title, :url, :description, :creator)
    # params.require(:post).permit! # Allow everything
    #if user.admin?
    #  permit!
    #else
    #  permit (:title, :url, :description, :creator)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
