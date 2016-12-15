Rails.application.routes.draw do
  root 'users#index'
resources :service_rides
  resources :users
  resources :rides

    resources :services, shallow: true do
resources :rides
collection do
get :clain
end

end
  resources :churches, shallow: true do
resources :services
    collection do
	get :attend
end
  end

  get 'login', to: 'logins#new', as: :login
  post 'login', to: 'logins#create', as: :logins
  delete 'logout', to: 'logins#destroy', as: :logout
 end
