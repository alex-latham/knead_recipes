Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  get '/profile', to: 'users#show'
  get '/profile/friends', to: 'friends#index'
  post '/profile/friends', to: 'friends#create'
  resources :welcome, only: [:index, :show]

  root 'welcome#index'

  delete '/logout', to: 'sessions#destroy'

  get 'auth/google_oauth2', as: 'google_login'
  get 'auth/google_oauth2/callback', to: 'sessions#create'

end
