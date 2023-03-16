Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get "dashboard", to: "pages#dashboard" # route du dashboard
  get "events/:id/invite", to: "events#invite", as: :invite # page d'invitation
  get "events/:event_id/bars", to: "bars#index", as: :bars
  post "events/:event_id/bars", to: "bars#create_bars", as: :create_bars
  get "events/:id/barocentre", to: "events#barocentre", as: :barocentre  # page de la map avec barocentre
  get "events/:event_id/bars/map", to: "bars#map", as: :map # page de la map avec les bars
  get "events/:event_id/event_users/map", to: "event_users#map", as: :map_event_users # page de la map avec les event_users
  resources :events, only: [:new, :create, :show] do # route du new, show, create event
    get "/classment", to: "bars#classment", as: :classment # page du classement
    get :choose_bar
    get "/itineraire", to: "events#itineraire", as: :itineraire # page de l'itinéraire
    resources :votes, only: [:create]
    resources :event_users, only: [:new, :create, :index] # route du new, create, index event_user
  end
  resources :event_users, only: [:destroy]
end
