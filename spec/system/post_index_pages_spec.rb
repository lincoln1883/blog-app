require 'rails_helper'

RSpec.describe 'Post/Index', type: :system do
  before do
    driven_by(:rack_test)
  end
  describe 'Index page' do
    let(:user) { User.create(name: 'Test User', bio: 'its me again jah jah', photo: 'https://picsum.photos/200/300', posts_counter: 1) }
    let!(:post) { user.posts.create(title: 'Test Post', text: 'This is the body of the post.') }
    it 'displays user information and post details' do
      visit user_posts_path(user.id)
    end
    it 'should display username' do
      visit user_posts_path(user.id)
      expect(page).to have_content(user.name)
    end
    it 'should display photo' do
      visit user_posts_path(user.id)
      expect(page).to have_selector("img[src*='#{user.photo}']")
    end
    it 'should display number of posts' do
      visit user_posts_path(user.id)
      expect(page).to have_content("number of posts: #{2}")
    end
    it 'should display the Post title' do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.title)
    end
    it 'should display Post text' do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.text)
    end
    it 'should display comments count' do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.comments_counter)
    end
    it 'should display likes count' do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.likes_counter)
    end
    it 'should display pagination button' do
      visit user_posts_path(user.id)
      expect(page).to have_content('Previous')
      expect(page).to have_content('Next')
    end
    it 'should redirect to the user show page' do
      visit user_posts_path(user.id)
      within '.shadow-2xl', text: post.title do
        click_link 'Read more'
      end
      expect(current_path).to eq(user_post_path(user.id, post.id))
      expect(page).to have_content(post.title)
    end
  end
end
