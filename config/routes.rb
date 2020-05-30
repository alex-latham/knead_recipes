Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  get '/profile/friends', to: 'friends#index'
  post '/profile/friends', to: 'friends#create'
  resources :welcome, only: [:index, :show]

  root 'welcome#index'

  delete '/logout', to: 'sessions#destroy'

  resources :search, only: [:index, :create]

  resources :recipes, only: [:index]

  resources :welcome, only: [:index, :show]

  namespace :profile do
    get '/', to: 'users#show'
    get '/edit', to: 'users#edit'
    patch '/edit/:id', to: 'users#update'
    # get '/friends', to: 'friends#index'
    # post '/friends', to: 'friends#create'
  end

  get 'auth/google_oauth2', as: 'google_login'
  get 'auth/google_oauth2/callback', to: 'sessions#create'

end
