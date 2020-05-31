Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  delete '/logout', to: 'sessions#destroy'

  resources :search, only: [:create]

  resources :recipes, only: [:index, :show]

  resources :favorites, only: [:index, :create, :destroy]

  namespace :profile do
    get '/', to: 'users#show'
    get '/edit', to: 'users#edit'
    patch '/edit/:id', to: 'users#update'
    get '/friends', to: 'friends#index'
    get '/friends/:id', to: 'friends#show'
    post '/friends', to: 'friends#create'
  end

  get 'auth/google_oauth2', as: 'google_login'
  get 'auth/google_oauth2/callback', to: 'sessions#create'

end
