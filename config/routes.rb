Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :rides
  resources :churches, shallow: true do
    resources :services
  end

  get 'login', to: 'logins#new', as: :login
  post 'login', to: 'logins#create', as: :logins
  delete 'logout', to: 'logins#destroy', as: :logout
 end
