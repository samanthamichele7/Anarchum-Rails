Anarchum::Application.routes.draw do
  
  resources :categories, :except => [:index, :show]
  resources :forums, :except => :index do
    resources :topics, :shallow => true, :except => :index do
      resources :posts, :shallow => true, :except => [:index, :show]
    end
    root :to => 'categories#index', :via => :get
  end

  match "/faq",     to: 'static_pages#faq'
  match "/about",   to: 'static_pages#about'

  get "static_pages/about"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login',    to: 'devise/sessions#new',       as: :login
    get '/logout',    to: 'devise/sessions#destroy',       as: :logout
  end
  
  devise_for :users
  resources :users
end