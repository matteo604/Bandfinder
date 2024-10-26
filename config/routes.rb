Rails.application.routes.draw do
  # root route (home page)
  root to: 'bands#index'

  # devise routes for user authentication
  devise_for :users

  # users rotes
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    get 'my_band', to: "bands#my_band"
  end

  # bands routes
  resources :bands  do
    resources :chats, only: [:new, :create]
    resources :reviews, only: [:new, :create, :index]
  end

  # chats messages ??
  resources :chats, only: [:index, :show] do
    resources :messages, only: [:create]
  end

  resources :messages, only: [:destroy]

  resources :reviews, only: [:destroy]
end
