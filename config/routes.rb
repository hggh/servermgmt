Servermgmt::Application.routes.draw do
  
  resources :sshusers do
    resources :sshuser_mbrs
  end

  resources :sshkey_groups do
    resources :sshkey_group_mbrs
  end

  resources :sshkeys
  
  resources :sshkeymgmts

  resources :server_groups
  resources :configkeys
  resources :configkey_values
  match 'home/settings' => 'static#page', :id => 'settings'
  resources :server_operation_systems
  resources :servertypes
  resources :domains
  match 'server_macs' => 'server_macs#index'
  resources :domains do
  
  
      resources :domain_records do
        collection do
    put :multiaction
    end
    
    
    end

    resources :nameservers, :controller => "domain_nameservers"
    resources :domain_soas
    resources :domain_option_values
  end

  resources :ip_types
  
  resources :servers do

    member do
      post 'puppet_userlist'
    end

    resources :ips
    resources :macs
    resources :server_key_values

    resources :server_interfaces do
        collection do
          post :selectinterface
        end
    end

  end

  resources :home
  resources :search
  resources :networks
  resources :users
  resources :settings
  match 'nameserver/getconfig/:nameserver_name/:server_system/:nameserver_config/' => 'nameservers#getconfig', :constraints => { :nameserver_name => /[\w\.\-_]+/, :server_system => /\w+/, :nameserver_config => /\w+/ }
  match 'puppetsshkeys/:fqdn' => 'ssh_public_keys#getKeys', :constraints => { :fqdn => /[\w\.\-_]+/ }
  resources :nameservers
  match 'login' => 'user_login#login', :as => :login
  match 'logout' => 'user_login#logout', :as => :logout
  match '/' => 'home#index'
  match '/:controller(/:action(/:id))'
end

