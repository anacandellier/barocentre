Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard" # route du dashboard
  resources :events, only: [:new, :create, :show] # route du new, show, create event
  get "events/:id/invite", to: "events#invite", as: :invite # page d'invitation
end
