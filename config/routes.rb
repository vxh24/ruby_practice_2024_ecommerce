Rails.application.routes.draw do
  namespace :admin, path: "admin" do
    root "home#admin_dashboard"

    resources :products
    resources :categories
    resources :orders, only: %i(index show update)
  end
  root "home#index"

  get "/login",to: "sessions#new"
  post "/login",to: "sessions#create"
  get "/logout",to: "sessions#destroy"
  delete "/logout",to:"sessions#destroy"
  get "carts/destroy", to: "carts#destroy", as: "destroy_carts"
  get "carts/add", to: "carts#add", as: "add_carts"
  get "products/add", to: "carts#add", as: "product_carts"
  patch "carts/update", to: "carts#update", as: "update_carts"
  get "carts", to: "carts#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new edit create show update)
  resources :account_activations, only: :edit
  resources :products
  resources :carts, only: [:show] do
    collection do
      post "add"
      patch "update"
      delete "destroy"
    end
  end
  get "checkout", to: "checkout#new", as: "new_checkout"
  post "checkout", to: "checkout#create", as: "create_checkout"
  get "orders", to: "orders#index", as: "order_index"
  get "orders/show/:id", to: "orders#show", as: "order_show"
  patch "orders/show/:id", to: "orders#update_info", as: "order_update"
  get "orders/update_status/:id", to: "orders#update_status", as: "order_update_status"
  get "orders/destroy/:id", to: "orders#destroy", as: "order_destroy"
end
