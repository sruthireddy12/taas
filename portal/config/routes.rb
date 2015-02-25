Rails.application.routes.draw do
  resources :applications
  resources :roles
  post '/roles/destory_all' => 'roles#destory_all', as: 'destory_all'

  devise_for :users, controllers: {registrations: 'registrations',passwords: 'passwords'}
  namespace :admin do
    get '/' => 'users#index'
    resources :users
    resources :organizations
  end
  get '/applications/:id/roles_users' => 'roles_users#index', as: 'roles_users'
  post '/applications/:id/roles_users/create' => 'roles_users#create'
  delete '/applications/:id/roles_users/destroy' => 'roles_users#destroy' ,as: 'destroy_role_user'
  post '/applications/delete_attachment' => 'applications#delete_attachment', as: 'delete_attachment'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  devise_scope :user do
    root "devise/sessions#new"
  end

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
