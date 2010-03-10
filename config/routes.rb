ActionController::Routing::Routes.draw do |map|
  map.resources :server_groups

  map.resources :configkeys
  
  map.resources :configkey_values

  map.connect 'home/settings', :controller => 'static', :action => 'page', :id => 'settings'
  
  map.resources :server_operation_systems

  map.resources :customers

  map.resources :servertypes

  map.resources :domains

  map.connect 'server_macs', :controller => 'server_macs', :action => 'index'

  map.resources :domains do |domain|
    domain.resources :records, :controller => "domain_records"
    domain.resources :nameservers, :controller => "domain_nameservers"
    domain.resources :domain_soas, :controller => "domain_soas"
  end 

  map.resources :ip_types

  map.resources :servers do |server|
    server.resources :ips
    server.resources :macs, :controller => "server_macs"
  end

  map.resources :home
  
  map.resources :search

  map.resources :networks
  
  map.resources :users

  map.resources :settings

  map.connect 'nameserver/getconfig/:nameserver_name/:server_system/:nameserver_config/',
      :controller => 'nameservers',
      :action => 'getconfig',
      :requirements => {
      :nameserver_name => /[\w\.\-_]+/,
      :server_system => /\w+/,
      :nameserver_config => /\w+/
      }

  map.resources :nameservers
  
  map.login 'login', :controller => 'user_login', :action => 'login'
  
  map.logout 'logout', :controller => 'user_login', :action => 'logout'
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
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
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"
  map.root :controller => "home"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
