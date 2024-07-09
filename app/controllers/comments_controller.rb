class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @commentable }
        format.turbo_stream
        CommentNotification.with(comment: @comment).deliver_later(@comment.commentable.user)


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

  def set_commentable
      @commentable = Post.find(params[:comment][:commentable_id]) if params[:comment][:commentable_type]== "Post"
      @commentable = Comment.find(params[:comment][:commentable_id]) if params[:comment][:commentable_type]== "Comment"
  end

  def comment_params
    # params.require(:comment).permit(:content, :commentable_type, :commentable_id)
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)

  end
end