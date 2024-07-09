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
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
