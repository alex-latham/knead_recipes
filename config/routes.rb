Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  delete '/logout', to: 'sessions#destroy'

  resources :search, only: [:index, :create]

  resources :recipes, only: [:index]
  
  resources :welcome, only: [:index, :show]

  get 'auth/google_oauth2', as: 'google_login'
  get 'auth/google_oauth2/callback', to: 'sessions#create'
end
