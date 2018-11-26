Rails.application.routes.draw do

  devise_for :users
  get 'home/index'
  get 'home/external', as: :external_root

  root "home#index"

  get '/searches/poll', to: 'searches#poll', as: :run_listings_poll
  resources :listings_polls


  resources :listings
  resources :searches
  resources :users

  get '/login', to: 'user_sessions#new', as: :new_user_session
  post '/login', to: 'user_sessions#create', as: :login
  delete '/logout', to: 'user_sessions#destroy', as: :logout

  post '/listings/mass_edit', to: 'listings#mass_edit'
  post '/listings/set_filter', to: 'listings#set_filter'
end
