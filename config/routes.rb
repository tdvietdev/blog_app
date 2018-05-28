Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  root "static_pages#home"

  get "set_language/en"
  get "set_language/vi"

  get "sessions/new"

  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new"

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  
  resources :users
  resources :entries
  resources :account_activations, only: [:edit]
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
    end

  resources :comments do
    member do
      get :new_reply
    end
  end
  resources :comments
end
