require 'rails_helper'

RSpec.describe 'Users/show', type: :system do
  before do
    driven_by(:rack_test)
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

  end
end
