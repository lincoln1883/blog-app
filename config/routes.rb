Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/users/:id/posts', to: 'posts#index'
  get '/users/:author_id/posts/:id', to: 'posts#show'
  get '/users/:id', to: 'users#show'
  root 'users#index'
end
