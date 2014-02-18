class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    # @comment = Comment.new(comment_params)
    # @comment.post_id = params[:post_id]
    # @comment.post = @post
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @comment)

    respond_to do |format|
      format.html do 
        if @vote.valid?
          flash[:notice] = "Your vote was counted, thanks!"
        else
          flash[:error] = "You can only vote on a comment once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end