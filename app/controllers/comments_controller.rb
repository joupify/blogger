class CommentsController < ApplicationController
  before_action :find_commentable, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @commentable }
      end
    else
      respond_to do |format|
        format.html { render 'posts/show', status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.commentable, notice: 'Comment was successfully deleted.'
  end


  private

  def find_commentable
    case params[:comment][:commentable_type]
    when "Post"
      @commentable = Post.find(params[:comment][:commentable_id])
    when "Comment"
      @commentable = Comment.find(params[:comment][:commentable_id])
    end
  end

  def comment_params
    # params.require(:comment).permit(:content, :commentable_type, :commentable_id)
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)

  end
end