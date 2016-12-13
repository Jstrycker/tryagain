Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :rides

  get 'login', to: 'logins#new', as: :login
  post 'login', to: 'logins#create', as: :logins
  delete 'logout', to: 'logins#destroy', as: :logout
 end
