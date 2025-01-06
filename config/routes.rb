Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :comments, only: [:create]

  root to: "posts#index"

  #resource :profile, only: [:show, :edit, :update], controller: "users"
end
