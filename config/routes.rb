Rails.application.routes.draw do
  # root route (home page)
  root to: 'bands#index'

  # devise routes for user authentication
  devise_for :users

  # users rotes
  resources :users, only: [:index, :show, :edit, :update] do
    resources :bands, only: [:new, :create]
    get 'account', on: :collection # Custom route for account view
    get 'my_band', to: "bands#my_band"
  end

  # bands routes
  resources :bands, except: [:new, :create] do
    resources :chats, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end

  # chats messages ??
  resources :chats, only: [:index, :show] do
    resources :messages, only: [:create]
  end

  resources :messages, only: [:destroy]

  # Routes for Reviews
  resources :reviews, only: [:destroy]
end
