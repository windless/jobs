Jobs::Application.routes.draw do
  resources :users, only: [:show, :create]
  resources :sessions, only: [:create]
  resources :projects, only: [:index, :show, :new, :create]

  resources :projects do
    resources :sprints, only: [:show, :create, :index, :new]
  end

  resources :sprints do
    resources :works, only: [:create]
  end

  resources :works do
    member do
      post :checkout
      post :finish
      post :review
    end
  end

  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  root to: 'home#index'
end
