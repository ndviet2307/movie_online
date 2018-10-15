Rails.application.routes.draw do
  root "movies#index"
  get "/home", to: "static_pages#home", as: :home
  get "/help", to: "static_pages#help", as: :help
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }, path: "", path_names: {sign_in: "login", sign_out: "logout",
      sign_up: "signup", edit:"edit-profile"}
  resources :bookmarks, only: :index
  resources :movies, only: :show do
    get "/ep-:order", to: "movies#show", as: :watch
    resources :bookmarks, only: :create
  end
  get "/list_movie", to: "movies#list_movie", as: :list_movie
  resources :movies
end
