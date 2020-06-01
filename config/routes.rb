Rails.application.routes.draw do
  root 'welcome#index'

  get 'auth/google_oauth2', as: 'google_login'
  get 'auth/google_oauth2/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :search, only: [:create]
  resources :recipes, only: [:index, :show]

  namespace :profile do
    get '/', to: 'users#show'
    get '/edit', to: 'users#edit'
    patch '/', to: 'users#update'
    resources :favorites, only: [:index, :create, :destroy]
    resources :friends, only: [:index, :create, :destroy]
  end

  resources :users, only: [:show] do
    resources :favorites, only: [:index]
    resources :friends, only: [:index]
  end
end
