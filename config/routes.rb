Rails.application.routes.draw do
  root 'application#home'

  get 'static_pages/about'
  get 'static_pages/nutrition_counseling'
  get 'static_pages/cooking_classes'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :users
  resources :appointments
  resources :recipes

  post '/appointments/get_availability' => 'appointments#get_availability'
  
end
