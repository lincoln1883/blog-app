require 'rails_helper'

RSpec.describe 'Users/Index', type: :system do
  before do
    driven_by(:rack_test)
  end
  describe 'Index page' do
    user = User.create(name: 'Test User', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
    it 'I can see the username of all other users.' do
      user = User.all
      visit users_path
      expect(page).to have_content(user.name)
    end
    it 'I can see the profile picture for each user.' do
      visit users_path
      expect(page).to have_css("img[src*='#{user.photo}']")
    end

    it 'I can see the number of posts for each user has written.' do
      visit users_path
      expect(page).to have_content(user.posts_counter)
    end
    it 'When I click on a user, I am redirected to that user show page' do
      user = User.create(name: 'Tommy', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
      visit users_path
      within '.card', text: user.name do
        click_link 'See posts'
      end
      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content(user.name)
    end
  end
end
