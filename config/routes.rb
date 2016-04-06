Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index, :show]
  resources :lessons, only: [:create, :show, :update]
  resources :words, only: :index

  namespace :admin do
    get "/" => "categories#index"
    resources :users, only: :destroy
    resources :categories
    resources :words, except: :show
  end
end
