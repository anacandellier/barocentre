Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard" # route du dashboard
  get "events/:id/invite", to: "events#invite", as: :invite # page d'invitation
  resources :events, only: [:new, :create, :show] do # route du new, show, create event
    resources :event_users, only: [:new, :create, :index]
  end

end
