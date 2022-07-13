Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :reading_records do
    patch "mark_as_read", on: :member
  end
  resources :reviews
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  get "/explore", to: "home#explore"
  root "home#index"
end
