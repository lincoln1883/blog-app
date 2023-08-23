Rails.application.routes.draw do

  post '/users/:author_id/posts', to: 'posts#create', as: :user_posts
  get '/users/:author_id/posts/new', to: 'posts#new', as: :current_user_posts
  get '/users/:author_id/posts/:id', to: 'posts#show'
  get '/users/:author_id/posts/:post_id/comments/new', to: 'comments#new', as: :new_author_post_comments
  post '/users/:author_id/posts/:post_id/comments', to: 'comments#create', as: :user_post_comments
  get '/users/:id', to: 'users#show'
  get '/users/:id/posts', to: 'posts#index'

  root  'users#index'
end
