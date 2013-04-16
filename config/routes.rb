Anarchum::Application.routes.draw do
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