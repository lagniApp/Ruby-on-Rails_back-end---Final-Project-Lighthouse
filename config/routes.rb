Rails.application.routes.draw do
  resources :coupons, only: [:index]
  resources :restaurants, only: [:index, :show,  :new, :create] do
    resources :coupons, only: [:index, :show, :new, :create] 
  end
  # post 'restaurants' => 'restaurants#login'
  # resources :tags

  namespace :admin do
    root to: 'dashboard#show'
    resources :restaurants, except: [:show]
  end

  root to: 'coupons#index'

  # resources :products, only: [:index, :show] do
  #   resources :reviews, only: [:create, :destroy]
  # end
  # resources :categories, only: [:show]

  # resource :cart, only: [:show] do
  #   put    :add_item
  #   delete :remove_item
  # end

  # resources :orders, only: [:create, :show]

  # namespace :admin do
  #   root to: 'dashboard#show'
  #   resources :products, except: [:edit, :update, :show]
  #   resources :categories, only: [:index, :new, :create]
  # end

    
  # these routes are for showing users a login form, logging them in, and logging them out.
  # get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  # get '/logout' => 'sessions#destroy'

  # These routes will be for signup. The first renders a form in the browse, the second will 
  # receive the form and create a user in our database using the data given to us by the user.
  # get '/signup' => 'users#new'
  # post '/users' => 'users#create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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



  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
