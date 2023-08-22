require 'rails_helper'

RSpec.describe Post, type: :request do
  describe 'Get /index' do
    it '#returns success' do
      get '/users/:id/posts'
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
    it '#should render index page' do
      get '/users/:id/posts'
      expect(response).to render_template(:index)
    end
    it '#should render the html body' do
      get '/users/:id/posts'
      expect(response.body).to include('Posts index page')
    end
  end
  describe 'Get /show' do
    it '#should return success' do
      get '/users/:id/posts/:id'
      expect(response.status).to eq 200
      expect(response).to have_http_status(:success)
    end
    it '#should return show page' do
      get '/users/:id/posts/:id'
      expect(response).to render_template(:show)
    end
    it '#should render the html body' do
      get '/users/:id/posts/:id'
      expect(response.body).to include('Posts show page')
    end
  end
end
