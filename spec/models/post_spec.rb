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
require 'rails_helper'

RSpec.describe Post, type: :model do
  #validations
  it { should validate_presence_of (:title)}
  it { should validate_presence_of (:description)}

  #associations}
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }

  describe 'it should create a post' do
  let(:user) { create(:user) }


    it 'should create a post' do
    post = Post.create(title: 'Test Post', description: 'This is a test post', user: user)
    expect(post).to be_valid
  end

end
end