ActionController::Routing::Routes.draw do |map|


  #map.connect 'entries/about', :controller => 'entries', :action => 'about'
  map.connect '/archive', :controller => 'entries', :action => 'archive'
  map.connect '/categories', :controller => 'entries', :action => 'categories'
  map.connect 'entries/contact_us', :controller => 'entries', :action => 'contact_us'
  map.connect 'entries/faq', :controller => 'entries', :action => 'faq'
  map.connect '/stats', :controller => 'entries', :action => 'stats'
  map.connect '/about', :controller => 'infos', :action => 'about'
   
  map.resources :tags
  
  #map.resources :rating, :member => { :rate => :post }
  map.rate '/rate', :controller => 'rating', :action => 'rate'


  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  

  map.resource :session
  
  map.resources :infos

  map.resources :users do |user|
    user.resources :userpics
  end

  
  map.resources :entries do |entry|
	entry.resources :comments
        entry.resources :tags
        entry.resources :pics
  end

  map.resources :comments

  map.resources :entries
  
  map.resources :pics
  map.resources :userpics
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #map.connect 'entries/:id', :controller => 'entries', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'entries'
  

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
