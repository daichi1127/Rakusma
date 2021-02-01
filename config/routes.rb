Rails.application.routes.draw do
  root 'home#index'

  resources :products
  get '/category/:id' => 'products#categorized_index'

  get 'carts' => 'carts#empty'
  resources :carts, only: [:show]
  
  get 'signup' => 'users#new'
  
  get 'login' => 'users#login_form', :as => 'login_form'
  post 'login' => 'users#login', :as => 'login'
  post 'logout' => 'users#logout'
  
  post '/users/:id' => 'users#update', :as => 'update_user'
  get '/users' => 'users#new', :as => 'users'
  resources :users, only: [:show, :create, :edit, :update]

  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'
  
  get '/order' => 'orders#new'
  post '/order' => 'orders#create', as: 'create_order'
  get '/complete' => 'orders#complete'
end