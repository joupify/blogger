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
require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Validations
  it { should validate_presence_of(:content) }

  # Associations
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should belong_to(:commentable) }

  describe 'comment creation' do
    let(:user) { create(:user) }

    it 'creates a parent comment' do
      post = create(:post)
      comment = post.comments.create(content: 'This is a parent comment', user: user)
      expect(comment).to be_valid
      expect(post.comments).to include(comment)
    end

    it 'creates a child comment' do
      parent_comment = create(:comment, :for_post)
      child_comment = parent_comment.comments.create(content: 'This is a child comment', user: user)
      expect(child_comment).to be_valid
      expect(parent_comment.comments).to include(child_comment)
    end

    it 'creates a baby comment' do
      parent_comment = create(:comment, :for_post)
      child_comment = parent_comment.comments.create(content: 'This is a child comment', user: user)
      baby_comment = child_comment.comments.create(content: 'This is a baby comment', user: user)
      expect(baby_comment).to be_valid
      expect(child_comment.comments).to include(baby_comment)
    end
  end
end

