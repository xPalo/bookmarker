Rails.application.routes.draw do
  resources :books

  resources :authors

  resources :reading_records do
    patch "mark_as_read", on: :member
    patch "mark_as_reading", on: :member
  end

  resources :reviews

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", sessions: "devise/sessions" }
  resources :users, :except => [:edit, :update, :destroy]

  get "/explore", to: "home#explore"
  get "/quote", to: "home#quote"
  match "lang/:locale", to: "home#change_locale", as: :change_locale, via: [:get]

  root "home#index"

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
