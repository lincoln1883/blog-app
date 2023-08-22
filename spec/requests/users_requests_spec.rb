require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'Get /index' do
    it '#returns success' do
      get '/'
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
    it '#renders the index page' do
      get '/'
      expect(response).to render_template(:index)
    end
    it '#render the html body' do
      get '/'
      expect(response.body).to include('Users index')
    end
  end
  describe 'Get /show' do
    it '#returns success' do
      get '/users/:id'
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
    it '#returns the user show page' do
      id = 1
      get "/users/#{id}"
      expect(response).to render_template(:show)
    end
    it '#renders the body' do
      id = 1
      get "/users/#{id}"
      expect(response.body).to include('User Show Page')
    end
  end
end
