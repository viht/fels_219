Rails.application.routes.draw do
  root "static_pages#home"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users, expect: :destroy
  resources :categories do
    resources :lessons
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :words
  resources :relationships, only: [:create, :destroy]
end
