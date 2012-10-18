Jobs::Application.routes.draw do
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  root to: 'home#index'
end
