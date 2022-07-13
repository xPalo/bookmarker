Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :reading_records
  resources :reviews
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  get "/explore", to: "home#explore"
  root "home#index"
end
