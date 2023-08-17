require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq(:author_id)
    end
    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:posts)
    end
    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:posts)
    end
  end
  describe 'validations' do
    it 'is valid with attributes' do
      user = described_class.create(name: 'user', bio: 'hello world', posts_counter: 1)
      expect(user).to be_valid
    end
    it 'is not valid without name' do
      user = described_class.create(name: nil)
      expect(user).not_to be_valid
    end
    it 'is not valid when is les than 3 chars' do
      user = described_class.create(name: 'er', bio: 'yes its me again', posts_counter: 0)
      expect(user).not_to be_valid
    end
    it 'is not valid when bio < 5 chars' do
      user = described_class.create(name: 'user', bio: 'y', posts_counter: 0)
      expect(user).not_to be_valid
    end
    it 'is not valid without bio' do
      user = described_class.create(name: 'user', bio: nil, posts_counter: 0)
      expect(user).not_to be_valid
    end
  end
  describe 'callbacks' do
    it 'updates posts_counter after commit if there are posts' do
      user = User.create(name: 'Test User', bio: 'it me again')
      Post.create(author: user, title: 'Post 1')
      Post.create(author: user, title: 'Post 2')
      Post.create(author: user, title: 'Post 3')
      user.update(name: 'Updated Name', bio: 'it me again')
      expect(user.posts_counter).to eq(user.posts.count)
    end
    it 'does not update posts_counter if there are no posts' do
      user = User.create(name: 'Test User', bio: 'it me again')
      user.update(name: 'Updated Name')
      expect(user.posts_counter).to eq(0)
    end
  end
  describe '#recent_posts' do
    it 'returns a limited number of recent posts' do
      user = User.create(name: 'Test User', bio: 'it me again lorem ipsum')
      Post.create(title: 'Post 1', text: 'Text 1', author: user, created_at: 7.days.ago)
      Post.create(title: 'Post 2', text: 'Text 2', author: user, created_at: 6.days.ago)
      Post.create(title: 'Post 3', text: 'Text 3', author: user, created_at: 5.days.ago)
      Post.create(title: 'Post 4', text: 'Text 4', author: user, created_at: 4.day.ago)
      Post.create(title: 'Post 5', text: 'Text 5', author: user, created_at: 3.day.ago)
      Post.create(title: 'Post 6', text: 'Text 6', author: user, created_at: 2.day.ago)
      Post.create(title: 'Post 7', text: 'Text 7', author: user, created_at: 1.day.ago)
      user.update(name: 'Updated Name', bio: 'it me again lorem ipsum')

      recent_posts = user.recent_posts(3)
      expect(recent_posts.count).to eq(3)
      expect(recent_posts.map(&:title)).to eq(['Post 7', 'Post 6', 'Post 5'])
    end
    it 'returns a limited number of recent posts' do
      user = User.create(name: 'Test User', bio: 'it me again lorem ipsum')
      Post.create(title: 'Post 1', text: 'Text 1', author: user, created_at: 7.days.ago)
      Post.create(title: 'Post 2', text: 'Text 2', author: user, created_at: 6.days.ago)
      Post.create(title: 'Post 3', text: 'Text 3', author: user, created_at: 5.days.ago)
      Post.create(title: 'Post 4', text: 'Text 4', author: user, created_at: 4.day.ago)
      Post.create(title: 'Post 5', text: 'Text 5', author: user, created_at: 3.day.ago)
      Post.create(title: 'Post 6', text: 'Text 6', author: user, created_at: 2.day.ago)
      Post.create(title: 'Post 7', text: 'Text 7', author: user, created_at: 1.day.ago)
      user.update(name: 'Updated Name', bio: 'it me again lorem ipsum')

      recent_posts = user.recent_posts(3)
      expect(recent_posts.count).not_to eq(5)
      expect(recent_posts.map(&:title)).to eq(['Post 7', 'Post 6', 'Post 5'])
    end
  end
end
