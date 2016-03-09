# -*- encoding : utf-8 -*-
InsalesApp::Application.routes.draw do 
  
  resources :purchase_invoice_ins
  resources :purchase_lists
  resources :users
  resources :purchase_invoices do 
    collection do
    get :autocomplete_company_title	 
      get :autocomplete_product_title
    end
  end

  resources :invoiceouts 
  resources :stocks
  resources :invoice_lists do
  	collection do
	  	get :autocomplete_company_title
	end
  	member do
      get :print
	end
	end
  resources :invoices do
  collection do
	  	get :autocomplete_company_title
	end
  	member do
      get :print
	end
	end
	
  resources :sales
  resources :companies do 
  	collection do
  		get :getcompany
  	end
  end

  resources :clients do
  	collection do
	  	get :autocomplete_company_inn
	end
  end
			  	
  resources :line_items
  resources :couriers
  resources :posts
  resources :dpds do 
    collection do 
      get :updatedpd  
    end
  end

  resources :citilinks do
  	collection do
  		get :downloadproduct
  		get :updateproduct
  	end
  end	
  
  resources :treolans  do
    collection do
      post :import
      get :fillquantity
    end
  end
  
  resources :imls do 
    collection do 
      get :updateiml  
    end
  end
   
  resources :mycouriers
  
  
  resources :sskoms do
    collection do
      post :import
    end
  end  

  resources :statuses
  
  resources :icrs do
  	collection do
  		get :downloadproduct
  		get :updateproduct
  	end
  end
  	
  resources :ipmatikas do
    collection do
      post :import
    end
  end  

  resources :vimcoms do
    collection do
      post :import
    end
  end
  
  resources :energies do
    collection do
      post :import
      get :updateproduct
    end
  end
  
  resources :angels do
    collection {post :import}
  end
    
  resources :rrcs do
  	collection do
  		get :downloadproduct
  		get :updateproduct
  	end
  end
  
  resources :emags do 
  	collection do
  		get :downloadproduct
  		get :updateproduct
  	end
  end
  
  resources :vendors
  
  resources :homyproducts do
  	collection {post :import}
  end
  resources :products do
  	collection do
  		get :downloadproduct
  		get :updateproduct
  		get :checkquantity
  		get :synchronize
  		post :import
  	end
  end
  
  resources :iorders do 
    collection do 
      get :downloadorder
      get :updateorder
      get :checkdelivery
      get :autocomplete_product_title
    end
    member do
      get 'print'
	end
  end
  resources :orderstatuses
  resources :orders
  
  resources :order_status

  root :to => 'main#index'
  get '/main',         :to => 'main#index',            :as => :main 
  
  resource  :session, only: [:new, :create, :destroy]
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # resource  :session do
#     collection do
#       get :autologin
#     end
#   end
# 
#   get '/install',      :to => 'insales_app#install',   :as => :install
#   get '/uninstall',    :to => 'insales_app#uninstall', :as => :uninstall
#   get '/login',        :to => 'sessions#new',          :as => :login
#   get '/main',         :to => 'main#index',            :as => :main           
        
   
  #get ':controller/:action/:id'
  #get ':controller/:action/:id.:format'
end 
