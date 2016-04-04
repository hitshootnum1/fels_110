Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "signup" => "user/users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  namespace :user do
    get "/" => "dashboard#index"
    resources :users
    resources :relationships, only: [:create, :destroy]
    resources :categories, only: [:index, :show]
    resources :lessons, only: [:create, :show, :update]
    resources :words, only: :index
  end

  namespace :admin do
    get "/" => "dashboard#index"
    resources :users, only: :destroy
    resources :categories, except: :show
    resources :words, except: :show
  end
end
