Rails.application.routes.draw do

  root 'sessions#new'
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:show, :create, :edit, :update] do
    resources :friends, only: [:index, :create, :destroy]
  end
  
  resources :slots, only: [:index, :create, :update]
  
  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
