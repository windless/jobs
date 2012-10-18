Jobs::Application.routes.draw do
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
  root to: 'home#index'
end
