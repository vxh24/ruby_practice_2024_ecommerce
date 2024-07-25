Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get "product", to: "home#product"
  get "cart", to: "home#cart"

  get "/login", to: "sessions#new"

  get "/signup", to: "users#new"
end
