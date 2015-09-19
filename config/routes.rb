Rails.application.routes.draw do
  resources :projects
  devise_for :organizations
  resources :users
  resources :projects
  resources :organizations
  
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  #developerland
  get '/developer/:id' => 'users#show'
  get '/developer/:id/dash' => 'users#index'
  get '/developer/:id/settings' => 'users#edit'
  post '/developer/:id/update' => 'users#update'
end
