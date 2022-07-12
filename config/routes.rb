Rails.application.routes.draw do
  resources :books
  resources :authors
  #get "users/auth/google_oauth2/callback"
  #get "users/auth/google_oauth2"
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  root "home#index"
end
