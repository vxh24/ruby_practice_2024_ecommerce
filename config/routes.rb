Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
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
