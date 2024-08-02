Rails.application.routes.draw do
  namespace :admin, path: "admin" do
    root "home#admin_dashboard"

    resources :products
    resources :categories
  end

  root "home#index"

  get "product", to: "home#product"
  get "cart", to: "home#cart"

  get "/login",to: "sessions#new"
  post "/login",to: "sessions#create"
  get '/logout',to: 'sessions#destroy'
  delete "/logout",to:"sessions#destroy"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new edit create show)
  resources :account_activations, only: :edit
end
