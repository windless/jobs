Jobs::Application.routes.draw do
  resources :users, only: [:show, :create]
  resources :sessions, only: [:create]
  resources :projects, only: [:index, :show, :new, :create]
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  root to: 'home#index'
end
