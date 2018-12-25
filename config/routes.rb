Rails.application.routes.draw do
  root 'application#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  resources :exercises
  resources :workout_excercises
  resources :gyms
  resources :workouts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
