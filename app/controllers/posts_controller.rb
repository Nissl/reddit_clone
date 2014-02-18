class PostsController < ApplicationController
  #rails 3: before_filter
  #use before_action for instance variables, redirect on condition
  before_action :set_post, only: [:vote, :show, :edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator_or_admin, only: [:edit, :update]

  def index
    @posts = Post.all(:order => 'created_at DESC', :limit => 50).sort_by{|x| x.total_votes}
  end

  def show
    @comment = Comment.new
    # respond_to do |format|
    #   format.json do 
    #     render json: @post #calls @post.to_json - parses data, builds object
    #   end
    #   format.xml do 
    #     render xml: @post
    #   end
    #   format.html
    # end
  end

  def new
    @post = Post.new
    @category = Category.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user 
    @post.title.capitalize!
    @post.description.capitalize!
    
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else 
      render :new 
    end
  end

  def edit
    @category = Category.new
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "You updated your post"
      redirect_to posts_path
    else
      render :edit 
    end
  end

  def vote
    #don't need strong paramaters because not mass assigning from input
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    respond_to do |format|
      format.html do 
        if @vote.valid?
          flash[:notice] = "Your vote was counted, thanks!"
        else
          flash[:error] = "You can only vote on a post once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
    # :category_ids => []
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator_or_admin
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end
end


