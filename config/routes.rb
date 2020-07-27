Rails.application.routes.draw do

  root 'static_pages#top'
  get  '/terms_of_service', to: 'static_pages#terms_of_service'
  get  '/privacy_policy', to: 'static_pages#privacy_policy'
  
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    get 'reset_password', on: :collection
    member do
      patch 'update_password'
      get   'edit_card'
      post  'update_card'
    end
    resources :plants do
      post 'new_zip', on: :collection, to: 'plants#new'
      post 'edit_zip', on: :member, to: 'plants#edit'
    end
    resources :clients do
      post 'new_zip', on: :collection, to: 'clients#new'
      post 'edit_zip', on: :member, to: 'clients#edit'
    end
    resources :orders do
      collection do
        get 'traded'
        get 'unpaid'
      end
    end
  end
end
