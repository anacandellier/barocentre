Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard" # route du dashboard
  resources :events, only: [:new, :create] # route du new event
end
