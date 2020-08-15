Rails.application.routes.draw do
    root to: "top#index"
    get "sign_in" => "sessions#new", as: :sign_in
    post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy" 
  
    resources :users, except: [:edit, :update]
    resources :articles
    resource :account, only: [:show, :edit, :update] 
    resource :password, only: [:show, :edit, :update]
  
     namespace :admin do 
       root "top#index"
       resources :users, except: [:new, :create ] 
     end
  
end
