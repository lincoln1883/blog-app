require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    post 'Creates a Comment' do
      tags 'Comments'
      consumes 'application/json', 'application/xml'
      parameter name: :pet, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: %w[id author_id post_id text]
      }
      let(:user_id) do
        User.create(
          name: 'Test User',
          bio: 'Test Bio',
          email: 'test@example.com',
          role: nil
        ).id
      end
      let(:post_id) do
        Post.create(
          author_id: user.id,
          title: 'Test Post Title',
          text: 'Test Text Post'
        ).id
      end
      response '201', 'Comment created' do
        let(:comment) do
          Comment.create(
            author_id: user_id,
            post_id:,
            text: 'Test Comment'
          )
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) do
          Comment.create(
            author_id: user_id,
            post_id:,
            text: ''
          )
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves all Comments for a specific Post' do
      tags 'Comments'
      produces 'application/json'

      response '200', 'Users found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   author_id: { type: :integer },
                   post_id: { type: :integer },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: %w[id author_id post_id text created_at updated_at]
               }
        let(:user_id) do
          User.create(
            name: 'Test User',
            bio: 'Test Bio',
            email: 'test@example.com',
            role: nil
          ).id
        end
        let(:post_id) do
          Post.create(
            author_id: user.id,
            title: 'Test Post Title',
            text: 'Test Text Post'
          ).id
        end
        run_test!
      end

      response '404', 'Users not found' do
        run_test!
      end
    end
  end
end
