# To deliver this notification:
#
# CommentNotification.with(commentt: @comment).deliver_later(current_user)
# CommentNotification.with(comment: @comment).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  deliver_by :database
  deliver_by :email, mailer: "CommentMailer", method: :new_comment
  # deliver_by :webpush, class: "DeliveryMethods::Webpush"

  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"
  #

  # Add required params
  param :comment

  # Define helper methods to make rendering easier.
  def message
    @comment = params[:comment]
    "#{@comment.user.name} commented on your post."
  end

  
  def url
    commentable = @comment.commentable
    commentable.is_a?(Post) ? post_path(commentable) : post_path(commentable.commentable)
  end
end
