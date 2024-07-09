class CommentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.new_message.subject
  #class CommentMailer < ApplicationMailer

  def new_comment
    @comment = params[:comment]

    mail(
      to: @comment.commentable.user.email,
      subject: "You have a new comment",
      from: "no-reply@example.com"
    )
  end
end
