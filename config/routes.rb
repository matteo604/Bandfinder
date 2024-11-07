Rails.application.routes.draw do
  # root route (home page)
  root to: 'pages#home'

  # devise routes for user authentication
  devise_for :users

  # users routes
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    get 'my_band', to: "bands#my_band"
  end

  # bands routes
  resources :bands do
    resources :chats, only: [:new, :create]
    resources :reviews, only: [:new, :create, :index]
    resources :band_sessions, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :band_sessions, only: [:show]  do # do we need this lonly route without the band id?? to be checked
    resources :applications, only: [:create]
  end

  # chats messages with the new check_updates route
  resources :chats, only: [:index, :show, :create] do
    resources :messages, only: [:create, :edit, :update, :destroy] do
      get 'check_updates', on: :collection
    end
    get 'unread_count', on: :collection    # For total unread count (navbar)
    get 'unread_count_per_chat', on: :collection # For unread counts per chat (index)
    get 'mark_all_as_read', on: :collection # Route to mark all messages as read in index view
  end

  resources :applications, only: [:destroy]
  resources :messages, only: [:destroy]
  resources :reviews, only: [:destroy]

  get "search", to: 'pages#search'
  get "about", to: 'pages#about'
end
