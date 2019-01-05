Rexaminator::Application.routes.draw do

  resources :categories
#  resources :answers
  resources :questions
  resources :categories
  resources :feedbacks

  resources :exam_questions do
    member do
      put :reset
      get :review
    end
  end

  resources :exams do
    member do
      get :start
      get :go
      get :finish
      get :export
    end
  end

  resources :sessions

  match 'admin',  :to => 'exams#index'
  match 'login',  :to => 'sessions#new'
  match 'logout', :to => 'sessions#destroy'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   root :to => 'exams#new'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  match '/:controller(/:action(/:id))(.:format)'

end

