# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer

class CommentMailerPreview < ActionMailer::Preview
    def new_comment
      CommentMailer.with(comment: Comment.last).new_comment
    end
  end
  