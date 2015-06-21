Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  get 'manage_aids/mpeople'

  get 'items/get_item'
  get 'items/get_sub'
  get 'items/close_new_modal'
  get 'items/get_pdf'
  

  get 'home/search'
  get 'home/update_subcategories'
  get 'home/hierarchy'
  get 'home/get_tag_names'

  get 'categories/get_category'
  get 'categories/close_new_modal'
  get 'categories/get_pdf'

  get 'tags/get_tag'
  get 'tags/close_new_modal'
  get 'tags/get_pdf'

  get 'people/get_person'
  get 'people/close_new_modal'
  get 'people/get_pdf'
  post 'people/reset_pass'

  get 'services/get_service'
  get 'services/close_new_modal'
  get 'services/get_pdf'

  get 'locations/get_location'
  get 'locations/close_new_modal'
  get 'locations/get_pdf'

  get 'roles/get_rolpeople'
  get 'roles/close_new_modal'

  get 'check_outs/release'
  get 'check_outs/check_item_in'

  post 'users/ureserve'
  post 'users/urequest'
  get 'users/requests'
  get 'users/cancel_check_out'
  get 'users/check_outs'

  get 'signup'  => 'users#new' 
  resources :users

  resources :home
  resources :categories
  resources :check_ins
  resources :check_outs
  resources :items
  resources :locations
  resources :people
  resources :requests
  resources :roles
  resources :services
  resources :sub_categories
  resources :tags

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
end
