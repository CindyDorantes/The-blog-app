Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # get '/users/:user_id/posts', to: 'posts#index'
  # get '/users/:user_id/posts/:id', to: 'posts#show'
end
