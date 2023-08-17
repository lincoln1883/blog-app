require 'rails_helper'

RSpec.describe Like, type: :model do
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
    let!(:post) { Post.create(author: user, title: 'Test ', text: 'Test Text Title lorem ipsum') }

    it 'increments likes_counter after create' do
      like = Like.new(post: post, author: user)
      expect { like.save }.to change { post.reload.likes_counter }.by(1)
    end
    it 'decrements likes_counter after destroy' do
      like = Like.create(post: post, author: user)
      expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
    end
  end
end



