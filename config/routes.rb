Rails.application.routes.draw do
  get 'index/new'

  devise_for :users
  
  root to: "home#index"
  resources :users do
   member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  
  resources :events do
    resource :favorites, only: [:create, :destroy]
    resource :interesteds, only: [:create, :destroy]
    resource :absences, only: [:create, :destroy]
    resource :posts, only: [:show, :new, :create]
    resources :comments, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]  
  end
  resources :regions
  resources :prefectures do
     
  end
  get "search" => "searches#search"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
