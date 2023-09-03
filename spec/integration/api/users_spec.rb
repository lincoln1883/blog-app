require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  before(:each) do
    @user = User.create(
      name: 'Test User',
      bio: 'Test Bio',
      email: 'test@example.com',
      role: 'user'
    )
  end
  path '/api/v1/users' do
    get 'List all users' do
      tags 'Users'
      produces 'application/json'
      response '200', 'user found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   bio: { type: :string },
                   photo: { type: :string },
                   role: { type: :string }
                 },
                 required: %w[id name bio email]
               }
        let!(:user) do
          User.create(
            name: 'Test User',
            bio: 'Test Bio has good bio',
            email: 'test@example.com',
            role: 'user'
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
