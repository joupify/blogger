# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
FactoryBot.define do
  factory :post do
    association :user
    title { "MyString" }
    description { "MyText" }
  end
end
