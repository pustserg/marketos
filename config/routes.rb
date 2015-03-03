Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :categories, shallow: true, only: [:index, :show] do
    resources :goods, only: [:index, :show] do
      post 'add_to_cart', on: :member
    end
  end

  # resources :carts, only: :destroy
  get '/cart', to: 'carts#show', as: 'cart'
  delete '/cart', to: 'carts#destroy', as: 'delete_cart'
  resources :cart_items, only: :destroy do
    patch 'increase', on: :member
    patch 'decrease', on: :member
  end

  resources :orders, only: [:new, :create, :show]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'profile', to: 'users#show', as: :profile
  get 'profile/edit', to: 'users#edit', as: 'edit_profile'
  get 'article/:id', to: 'articles#show', as: :article
  resources :users, only: [:create, :update]
  resources :sessions, only: [:create]

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :categories
    resources :goods
    resources :articles
    resources :orders do
      patch 'change_status', on: :member
    end
  end

  root 'categories#index'

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
end
