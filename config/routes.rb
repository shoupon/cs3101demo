Demo::Application.routes.draw do
  #resources :addresses
  #resources :attractions
  #resources :cities
  #resources :countries

  resources :users do
    resources :trips do
      member do
        get 'upload'
        post 'upload' => "trips#upload_action"
      end
    end
  end
  resources :sessions, :only => [:create, :destroy, :new]
  resources :trips, :only => [:index]
  resources :photos, :only => [:show]

  get "users/:id/edit_avatar" => "users#edit_avatar", :as => "edit_avatar"
  patch "users/:id/edit_avatar" => "users#update_avatar"
  put "users/:id/edit_avatar" => "users#update_avatar"
  get 'users/:id/password' => "users#edit_password", :as => "edit_password"
  patch "users/:id/password" => "users#update_password"
  put "users/:id/password" => "users#update_password"

  get "signup" => "users#new", :as => "signup"
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "/images/*path" => "gridfs#serve"

  get ":id" => "users#showname"

  #get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'trips#index'

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
