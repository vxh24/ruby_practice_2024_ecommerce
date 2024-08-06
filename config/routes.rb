Rails.application.routes.draw do
  namespace :admin, path: "admin" do
    root "home#admin_dashboard"

    resources :products
    resources :categories
  end
  root "home#index"

  get "/login",to: "sessions#new"
  post "/login",to: "sessions#create"
  get "/logout",to: "sessions#destroy"
  delete "/logout",to:"sessions#destroy"
  get "carts/destroy", to: "carts#destroy", as: "destroy_carts"
  get "carts/add", to: "carts#add", as: "add_carts"
  patch "carts/update", to: "carts#update", as: "update_carts"
  get "carts", to: "carts#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new edit create show)
  resources :account_activations, only: :edit
  resources :products
  resources :carts, only: [:show] do
    collection do
      post "add"
      patch "update"
      delete "destroy"
    end
  end
end
