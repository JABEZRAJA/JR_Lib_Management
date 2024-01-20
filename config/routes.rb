Rails.application.routes.draw do
  devise_for :users
  root 'users#new'

  resources :users
  resources :sessions
  resources :books

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
