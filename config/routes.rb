Rails.application.routes.draw do
  # root route (home page)
  root to: 'pages#home'

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
    resources :band_sessions, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :band_sessions, only: [:show]  do # do we need this lonly route without the band id?? to be checked
    resources :applications, only: [:create]
  end
  # chats messages ??
  resources :chats, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  resources :applications, only: [:destroy]

  resources :messages, only: [:destroy]

  resources :reviews, only: [:destroy]

  get "search", to: 'pages#search'
  get "about", to: 'pages#about'
end
