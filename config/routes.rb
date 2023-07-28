Rails.application.routes.draw do
  resources :users
  resources :sessions
  
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'home/index'

  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
