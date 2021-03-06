Rails.application.routes.draw do
  resources :users
  resources :books
  root to: 'landing#index'

  # Authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
