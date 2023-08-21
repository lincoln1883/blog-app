require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'Get /index' do
    it 'returns success' do
      get '/users/index'
      expect(response.status).to eq(200)
    end
  end
end
