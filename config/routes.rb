Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get "dashboard", to: "pages#dashboard" # route du dashboard
  get "events/:id/invite", to: "events#invite", as: :invite # page d'invitation
  get "events/:event_id/bars", to: "bars#index", as: :bars # page des bars
  resources :events, only: [:new, :create, :show] do # route du new, show, create event
    get "/classment", to: "bars#classment", as: :classment # page du classement
    get "/itineraire", to: "bars#itineraire", as: :itineraire # page de l'itinéraire
    resources :votes, only: [:create]
    resources :event_users, only: [:new, :create, :index] # route du new, create, index event_user
  end
end
