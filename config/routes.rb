Rails.application.routes.draw do

  post '/users/:author_id/posts', to: 'posts#create', as: :user_posts
  get '/users/:author_id/posts/new', to: 'posts#new', as: :current_user_posts
  get '/users/:author_id/posts/:id', to: 'posts#show'
  get '/users/:id', to: 'users#show'
  get '/users/:id/posts', to: 'posts#index'

  root  'users#index'
end
