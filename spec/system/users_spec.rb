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
end
