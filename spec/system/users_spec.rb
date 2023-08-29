require 'rails_helper'

RSpec.describe 'Users/index', type: :system do
  before do
    driven_by(:rack_test)
  end
  describe 'Index page' do
    user = User.create(name: 'Test User', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
    it 'should display the Logo' do
      visit root_path
      expect(page).to have_content('BlogApp')
    end
    it 'should display username' do
      visit '/users'
      expect(page).to have_content(user.name)
    end
    it 'should display photo' do
      visit '/users'
      expect(page).to have_selector("img[src*='#{user.photo}']")
    end
    it 'should display number of posts' do
      visit '/users'
      expect(page).to have_content("number of posts: #{user.posts_counter}")
    end
    it 'should redirect to the user show page' do
      user = User.create(name: 'Tommy', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
      visit '/users'
      within '.card', text: user.name do
        click_link 'See posts'
      end
      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content(user.name)
    end
  end

  describe 'Show page' do
    user = User.create(name: 'Test User', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
    let(:user) { create(:user, :post) }
    let(:post) { create(:post, user:) }

    before do
      visit user_path(user)
    end

    it 'should display user photo' do
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it 'should display username' do
      expect(page).to have_content(user.name)
    end

    it 'should display number of posts' do
      expect(page).to have_content("number of posts: #{user.posts_counter}")
    end

    it 'should display Bio' do
      expect(page).to have_content(user.bio)
    end

    it 'should display user\'s first 3 posts' do
      user.posts.limit(3).each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'should display button for viewing all user\'s posts' do
      expect(page).to have_link('See all posts')
    end

    it 'should redirect to the user\'s post' do
      expect(page).to have_link('See all posts')
    end
  end
end
