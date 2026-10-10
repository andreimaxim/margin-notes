Rails.application.routes.draw do
  get "/health", to: "notes#health"
  resources :notes, only: [:index, :create, :show] do
    post :archive, on: :member
    post :publish, on: :collection
    get :statistics, on: :collection
  end
  resources :exports, only: [:create, :show] do
    post :expire, on: :collection
    get :manifest, on: :collection
  end
  get "/export", to: "notes#export"
  get "/preview", to: "notes#preview"
  get "/cache-status", to: "notes#cache_status"
  get "/stream", to: "streams#show"
  get "(/locale/:locale)/products(/:id)", to: "notes#catalog", as: :catalog
  get "/freshness", to: "notes#freshness"
end
