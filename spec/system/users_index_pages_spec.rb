require 'rails_helper'

RSpec.describe 'Users/Index', type: :system do
  before do
    driven_by(:rack_test)
  end
  describe 'Index page' do
    user = User.create(name: 'Test User', bio: 'it me again', photo: 'photo1.png', posts_counter: 1)
    user2 = User.create(name: 'Test User2', bio: 'it me again', photo: 'photo2.png', posts_counter: 1)
    user3 = User.create(name: 'Test User3', bio: 'it me again', photo: 'photo3.png', posts_counter: 1)
    
    it 'I can see the username of all other users.' do
      user = User.all
      visit users_path
      expect(page).to have_content(user.name)
      expect(page).to have_content(user2.name)
      expect(page).to have_content(user3.name)
    end
    
    it 'I can see the profile picture for each user.' do
      visit users_path
      expect(page).to have_css("img[src*='photo1.png']")
      expect(page).to have_css("img[src*='photo2.png']")
      expect(page).to have_css("img[src*='photo3.png']")
    end

    it 'I can see the number of posts for each user has written.' do
    user = User.create(name: 'Test User', bio: 'it me again', photo: 'photo1.png', posts_counter: 1)
      5.times do |i|
          Post.create(author: user, text: "This is a test post number #{i}")
        end
      
      visit users_path
      
      expect(page).to have_content("number of posts: #{user.posts_counter}")
      save_and_open_page
    end
    it 'When I click on a user, I am redirected to that user show page' do
      user = User.create(name: 'Tommy', bio: 'it me again', photo: 'photo1.png', posts_counter: 1)
      visit users_path
      within '.card', text: user.name do
        click_link 'See posts'
      end
      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content(user.name)
    end
  end
end
