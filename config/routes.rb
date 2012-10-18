Jobs::Application.routes.draw do
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
  root to: 'home#index'
end
