Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :reading_records
  #get "users/auth/google_oauth2/callback"
  #get "users/auth/google_oauth2"
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  root "home#index"
  get "/explore", to: "home#explore"
end
