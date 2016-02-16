Rails.application.routes.draw do
  devise_for :users
  
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "help" => "static_pages#help"

  get "dispatcher" => "request_dispatcher#main"
  get "error/index"
  get "application" => "request_dispatcher#app_dispatcher"
  
  resources :notification, only: [:index, :show]

  namespace :supplier do
  	get "profile" => "home#index"
    post "approve_request" => "requests#approve"
    resources :vehicles
    resources :requests, only: [:show]    
  end

  namespace :admin do
    get "home" => "home#index"
    post "checkaction" => "home#checkaction"
  end

  namespace :customer do
    resources :requests
    get "profile" => "profile#show"
  end
end
