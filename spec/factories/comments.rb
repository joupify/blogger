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

FactoryBot.define do
  factory :comment do
    association :user
    content { "MyString" }
    
    # Default association is with a post
    association :commentable, factory: :post

    # Trait for associating with a post
    trait :for_post do
      association :commentable, factory: :post
    end

    # Trait for associating with a comment
    trait :for_comment do
      association :commentable, factory: :comment
    end
  end
end