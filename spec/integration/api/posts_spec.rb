require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  path '/api/v1/users/{user_id}/posts' do
    get 'Retrieves all Posts for a specific User' do
      tags 'Posts'
      produces 'application/json'
      response '200', 'Users found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   author_id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: %w[id title text comments_counter likes_counter created_at updated_at]
               }
        let(:user_id) do
          User.create(
            name: 'Test User',
            bio: 'Test Bio has great bio',
            email: 'test@example.com',
            role: 'user'
          ).id
        end
        let(:post) do
          Post.create(
            author_id: user.id,
            title: 'Test Post Title',
            text: 'Test Text Post'
          )
        end
        run_test!
      end
      response '404', 'Users not found' do
        run_test!
      end
    end
  end
end

