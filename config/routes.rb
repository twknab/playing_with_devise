Rails.application.routes.draw do
  resources :users
  resources :sessions
  
  # get 'home/index'
  
  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  post 'dashboard/update', to: 'dashboard#update', as: 'dashboard_update'
  
  # Defines the root path route ("/")
  root "home#index"
end
