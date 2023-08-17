require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'association' do
    it 'belongs to author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  describe 'callbacks' do
    let!(:user) { User.create(name: 'Test User', bio: 'it me again') }
    let!(:post) { Post.create(author: user, title: 'Test Title', text: 'Test Text lorem ipsum') }

    it 'increments comments_counter after create' do
      expect do
        Comment.create(post:, author: user, text: 'Test Comment')
        post.reload
      end.to change { post.comments_counter }.by(1)
    end
  end
end
