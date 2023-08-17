require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'association' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq(:author_id)
    end
    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.name).to eq(:comments)
    end
    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.name).to eq(:likes)
    end
  end
  describe 'validations' do
    it 'should be a valid post' do
      user = User.create(name: 'Test User', bio: 'Test bio', posts_counter: 0)
      post = user.posts.build(title: 'test title', text: 'some text i dont have', comments_counter: 0, likes_counter: 0)
      expect(post.valid?).to be(true)
    end
    it 'should not be a valid post' do
      user = User.create(name: 'Test User', bio: 'Test bio', posts_counter: 0)
      post = user.posts.build(title: '', text: '', comments_counter: 0, likes_counter: 0)
      expect(post.valid?).to be(false)
    end
    it 'validates comments_counter numericality' do
      post = described_class.new(comments_counter: 'abc')
      expect(post).not_to be_valid
    end
  end
  describe 'callbacks' do
    it 'updates posts_counter after commit if there are posts' do
      user = User.create(name: 'Test User', bio: 'it me again')
      post1 = Post.create(author: user, title: 'Post 1')
      post2 = Post.create(author: user, title: 'Post 2')
      post3 = Post.create(author: user, title: 'Post 3')
      user.update(name: 'Updated Name', bio: 'it me again')
      expect(user.posts_counter).to eq(user.posts.count)
    end
    it 'does not update posts_counter if there are no posts' do
      user = User.create(name: 'Test User', bio: 'it me again')
      user.update(name: 'Updated Name')
      expect(user.posts_counter).to eq(0)
    end
    it 'updates counters after create' do
      user = User.create(name: 'Test User', bio: 'it me again')
      post = Post.create(author: user, title: 'Test Title', text: 'Test Text')

      expect(post.comments_counter).to eq(0)
      expect(post.likes_counter).to eq(0)
    end
    it 'updates counters after destroy' do
      user = User.create(name: 'Test User', bio: 'it me again')
      post = Post.create(author: user, title: 'Test Title', text: 'Test Text')
      post.destroy
      expect(post.comments_counter).to eq(0)
      expect(post.likes_counter).to eq(0)
    end
  end
end
