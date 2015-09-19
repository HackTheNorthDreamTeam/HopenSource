Rails.application.routes.draw do
  resources :projects
  devise_for :organizations
  
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

  #organizationland
  get '/organization/:id' => 'organizations#show'
  get '/organization/:id/dash' => 'organizations#index'

  #projectland
  get '/project/:id' => 'projects#show'
  get '/project/:id/edit' => 'projects#edit'
  post '/project/:id/update' => 'projects#update'
  get '/project/new' => 'projects#new'
  post '/project/create' => 'projects#create'
end
