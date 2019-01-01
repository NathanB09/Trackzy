Rails.application.routes.draw do
  root 'application#home'

  # sessions management
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  # users management
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  resources :users, only: [:index, :new, :create, :show]

  # workouts management
  resources :workouts

  resources :gyms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
