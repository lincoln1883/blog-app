require 'rails_helper'

RSpec.describe 'Post/Index', type: :system do
  before do
    driven_by(:rack_test)
  end
  describe 'Index page' do
    let(:user) { User.create(name: 'Test User', bio: 'its me again jah jah', photo: 'https://picsum.photos/200/300', posts_counter: 1) }
    let!(:post) { user.posts.create(title: 'Test Post', text: 'This is the body of the post.') }
    let!(:comment) { post.comments.create(text: 'Test Comment', post_id: post.id, author_id: user.id) }
    it "I can see the user's profile picture." do
      visit user_posts_path(user.id)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end
    it "I can see the user's username." do
      visit user_posts_path(user.id)
      expect(page).to have_content(user.name)
    end
    it 'I can see the number of posts the user has written.' do
      visit user_posts_path(user.id)
      expect(page).to have_content(user.posts_counter)
    end
    it "I can see a post's title" do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.title)
    end
    it "I can see some of the post's body." do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.text)
    end
    it 'I can see the first comments on a post.' do
      visit user_posts_path(user.id)
      expect(page).to have_content(comment.text)
      expect(page).to have_content(comment.text)
      expect(page).to have_content(comment.text)
    end
    it 'I can see how many comments a post has' do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.comments_counter)
    end
    it 'I can see how many likes a post has' do
      visit user_posts_path(user.id)
      expect(page).to have_content(post.likes_counter)
    end
    it 'I can see a section for pagination if there are more posts than fit on the view' do
      visit user_posts_path(user.id)
      expect(page).to have_content('Previous')
      expect(page).to have_content('Next')
    end
    it "When I click on a post, it redirects me to that post's show page" do
      visit user_posts_path(user.id)
      within '.shadow-2xl', text: post.title do
        click_link 'Read more'
      end
      expect(current_path).to eq(user_post_path(user.id, post.id))
      expect(page).to have_content(post.title)
    end
  end
end
