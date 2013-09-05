HydroFlask::Application.routes.draw do
  
  resources :stores

  resources :ambassadors

  devise_for :accounts
  
  get '/email_subscriptions/new', :to => 'email_subscriptions#new'
  post '/email_subscriptions/subscribe', :to => 'email_subscriptions#subscribe', :as => 'subscribe_email'
  # expects parameter "the_email_address"
  get '/email_subscriptions/unsubscribe', :to => 'email_subscriptions#unsubscribe', :as => 'unsubscribe_email'
  
  resources :donations

  resources :charities
  
  resources :car_related_products

  resources :product_option_value_images

  resources :accounts

  resources :line_item_options

  resources :related_products

  resources :reviews

  resources :product_option_values

  resources :product_types

  resources :brands

  resources :option_types

  resources :option_values

  resources :options

  resources :orders do
    collection do
      post 'payment'
    end
  end

  post "orders/confirm"

  resources :line_items
  post "line_items/create"

  resources :carts


  get "pages/edit"

  get "pages/index"

  get "pages/create"

  match "pages/5-back" => "pages#five_back"
  match "pages/hydro-flask-technology" => "pages#hydro_flask_technology"
  match '/pages/hydro-flask-social' => 'pages#hydro_flask_social'

  match 'charities/charity_detail/:id' => 'charities#charity_detail'
  match '/donate' => 'donations#new'

  resources :category_products


  resources :products do
    resources :product_images do
      collection do
        get :get_image
      end
    end
  end

  resources :categories

  resources :pages

  match '/netsuite/item/:id' => 'netsuite#item'
  match '/netsuite/items' => 'netsuite#items'
  match '/netsuite/order/:id' => 'netsuite#order'
  match '/netsuite/orders' => 'netsuite#orders'
  match '/netsuite/add' => 'netsuite#addOrder'

  # The priority is based upon order of creation:
  # first created -> highest priority.
  root to: 'static_pages#home'
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match '/mycart' => 'carts#show'

  match '/shop' => 'categories#shop'

  match '/:id' => 'pages#show'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
