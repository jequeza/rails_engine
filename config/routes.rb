Rails.application.routes.draw do
  get "/api/v1/items/find", to: "api/v1/items/find#show"
  get "/api/v1/merchants/find_all", to: "api/v1/merchants/find_all#index"
  get "/api/v1/merchants/most_revenue", to: "api/v1/merchants/most_revenue#index"
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      resources :items do
        resources :merchant, only: [:index]
      end
    end
  end
end
