Rails.application.routes.draw do

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get    '/users/:id/orders/traded', to: 'orders#traded', as: 'users_orders_traded'
  
  resources :users do
    resources :plants
    resources :clients
    resources :orders
  end
end
