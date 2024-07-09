# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  content          :text
#  user_id          :bigint           not null
#  commentable_type :string           not null
#  commentable_id   :bigint           not null
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true
  validates :user, presence: true




  
  
  after_create_commit do 
    if commentable_type == "Comment"
      parent_comment = Comment.find(commentable_id)
     broadcast_append_to "comments", target: "comment_#{parent_comment.id}_replies", partial: 'comments/comment', locals: { comment: self }
    else 
      broadcast_append_to "comments", partial: 'comments/comment', locals: { comment: self }
    end
  end

  after_update_commit -> { broadcast_replace_to "comments" }
  after_destroy_commit -> { broadcast_remove_to "comments" }



end
