Rails.application.routes.draw do

  get 'orders/new'

  get 'clients/index'

  get 'sessions/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    resources :plants
    resources :clients
    resources :orders
  end
end
