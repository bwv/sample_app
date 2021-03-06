Rails.application.routes.draw do


  get 'password_resets/new'
  get 'password_resets/edit'

  root   'static_pages#home'

  # Main pages
  get    'help'     => 'static_pages#help'   
  get    'about'    => 'static_pages#about'
  get    'contact'  => 'static_pages#contact'

  # Signup page/form for new user
  get    'signup'   => 'users#new'
  

  # Login page 
  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  resources :users do 
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]



  # the get method creates for example the following variables that can be used in HTML:
  #     help_path -> '/help'
  #     help_url  -> 'http://www.example.com/help'

  # --- the resources :microposts above creates the following: --- #
  #HTTP request  URL             Action    Purpose

  #POST          /microposts     create    create a new micropost
  #DELETE        /microposts/1   destroy   delete micropost with id 1

   # --- the resources :users with member nesting above creates the following: --- #
  #HTTP request  URL                    Action     Named route

  #GET           /users/1/following     following  following_user_path(1)
  #GET           /users/1/followers     followers  followers_user_path(1)


  # --- the resources :users method creates the following automatically: ---#
  # HTTP    request URL     Action    Named route           Purpose

  # GET     /users          index     users_path            page to list all users
  # GET     /users/1        show      user_path(user)       page to show user
  # GET     /users/new      new       new_user_path         page to make a new user (signup)
  # POST    /users          create    users_path            create a new user
  # GET     /users/1/edit   edit      edit_user_path(user)  page to edit user with id 1
  # PATCH   /users/1        update    user_path(user)       update user
  # DELETE  /users/1        destroy   user_path(user)       delete user


  # GET     /account_activation/<token>/edit edit edit_account_activation_url









  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
