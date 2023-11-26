Rails.application.routes.draw do
  # root path for endpoint info
  root "main#index"
  # endpoint 3: returns information about customer
  resources :customers, only: %i[show] do
    member do
      # endpoint 4: lists the customer's orders
      resources :customer_orders, path: "orders", only: %i[index]
    end
  end
  # endpoint 1: report a completed order
  resources :orders, only: %i[create]
end
