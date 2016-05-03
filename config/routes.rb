Rails.application.routes.draw do
  resources :locations
  resources :lines
  resources :documents
  resources :items
  devise_for :users, :skip => [:registrations]
#  as :user do
#    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
#    put 'users' => 'devise/registrations#update', :as => 'user_registration'
#  end
#  Solution above from: http://stackoverflow.com/questions/6734323/how-do-i-remove-the-devise-route-to-sign-up
  resources :users, except: [:create, :new]
  get 'new_user' => 'users#new', as: :new_user
#  get 'create_admin_user' => 'users#create', as: :create_user
#  get "admins/new_user" => "admins#new_user", as: :admins_new_user
  # Solution above from http://stackoverflow.com/questions/24875403/only-allow-admin-user-to-create-new-users-in-rails-with-devise-no-external-modu
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'locations#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'export/:id', to: 'locations#export', as: :locations_export
  get 'documents/:id/pdf' => 'documents#pdf', as: :pdf
  get 'locations/:id/:item_code/hpdf' => 'locations#hpdf', as: :hpdf
  get 'locations/history/:id/:item_code' => 'locations#history', as: :history

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
