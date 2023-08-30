require 'rails_helper'

RSpec.describe 'Posts/Show', type: :system do
  before do
    driven_by(:rack_test)
  end
  describe 'show page' do
    let(:user) { User.create(name: 'Test User', bio: 'its me again jah jah', photo: 'https://picsum.photos/200/300', posts_counter: 1) }
    let!(:post) { user.posts.create(title: 'Test Post', text: 'This is the body of the post.', author_id: user.id) }
    let!(:comment) { post.comments.create(text: 'Test Comment', post_id: post.id, author_id: user.id) }
    it 'should display the title' do
      visit user_post_path(user.id, post.id)
      expect(page).to have_content(post.title)
    end
    it 'should display the author' do
      visit user_post_path(user.id, post.id)
      expect(page).to have_content(post.author.name)
    end
    it 'should display the comments count' do
      visit user_post_path(user.id, post.id)
      expect(page).to have_content(post.comments_counter)
    end
    it 'should display the likes count' do
      visit user_post_path(user.id, post.id)
      expect(page).to have_content(post.likes_counter)
    end
    it 'should display the text' do
      visit user_post_path(user.id, post.id)
      expect(page).to have_content(post.text)
    end
    it 'displays usernames and comments of commenters' do
      visit user_post_path(user.id, post.id)
      post.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
        expect(page).to have_content(comment.text)
      end
    end
  end
end
