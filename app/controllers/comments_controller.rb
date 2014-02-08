class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render :show
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end