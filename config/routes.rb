Hidb::Application.routes.draw do
  
  resources :internships
  match '/unapproved' => 'internships#unapproved', :as => :unapproved
  
  resources :internships do
    collection do
    end
    member do
      post :approve
    end
  end

  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'authenticate' => 'user_sessions#create', :as => :authenticate, :via => :post
  #match 'signup' => 'users#new', :as => :signup
  match 'connect' => 'users#update', :as => :connect, :via => :post
  match "reset" => "users#detonate"
  resources :users
  resource :user_session
  match 'users(/:id)' => 'users#show', :as => :profile  
  
  match 'register' => 'users#new', :as => :register
  match 'signup' => 'users#create', :as => :signup, :via => :post
  
  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil
  match '/change/:token' => 'users#change_email', :as => :change, :token => nil
  match '/home' => 'users#home', :as => :home
  
  match 'quran_search' => 'qurans#search', :as => :quran_search
  resources :qurans do
    collection do
      get :random_ayat
  end
    member do
  end
    
  end
  resources :users do
    collection do
      get :top
    end
    member do
      post :follow
    end
  end

  match 'feedbacks/new' => 'feedbacks#new', :as => :new_feedback
  match 'feedbacks' => 'feedbacks#create', :as => :feedback
  resources :comments do
  
    member do
  post :destroy
  end
  
  end

  resources :finds do
    collection do
      get :quran_search
    end
    member do
    end
  end
  
  resources :words do
    collection do
      get :random
    end
    member do
      get :add_definition
    end
  end

  resources :definitions do
    collection do
      get :definition_of_the_day
      get :hot
      get :most_recent
      get :news_feed
    end
    member do
      post :add_comment
      post :vote
    end
  end

  match ':controller/auto_complete_for_word_name' => '#auto_complete_for_word_name', :format => 'json'
  match ':controller/:action' => '#index', :as => :auto_complete, :via => :get, :constraints => { :action => /auto_complete_for_\S+/ }

  match "/autocomplete" => "finds#autocomplete", :as => :autocomplete
  
  match "/about" => "info#about", :as => :about
  match "/contact" => "info#contact", :as => :contact
  match "/privacy" => "info#privacy", :as => :privacy
  match "/terms" => "info#terms", :as => :terms
  match "/resume" => "info#resume", :as => :resume
  match "/test" => "info#test", :as => :test
  
  root :to => "user_sessions#new" 

  # match 'controllerinfo' => '#index', :as => :with_options
  # match 'controllergames' => '#index', :as => :with_options
  match '/' => 'info#index'
  match '/:controller(/:action(/:id))'
end