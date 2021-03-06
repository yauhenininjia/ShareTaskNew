Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  #namespace :users do
  #  get 'omniauth_callbacks/facebook'
  #end

  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } 
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'} 
  #devise_for :users
  
  get 'home/switch_theme'
  
  scope "/:locale" do
    devise_for :users, skip: :omniauth_callbacks
    get 'users/change_locale'
    get 'users/delete_image'
    get 'users/top'
    get 'home/index'
    get 'search/tasks_by_tag'
    get 'search/tasks_by_section'
    get 'search/tasks_by_user'
    get 'search/search'
    get 'tasks/autocomplete_tag_name'
    resources :tags, only: [:index]
    resources :tasks, only: [:index, :show, :new, :create, :edit, :update]
    resources :attempts, only: [:new, :create]
    resources :users, only: [:index, :show, :edit, :update] do
      resources :tasks, only: [ :destroy] do
        resources :comments
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
