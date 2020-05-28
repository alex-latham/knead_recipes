Rails.application.routes.draw do
  get 'next/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/profile', to: 'users#show'
  get '/profile/friends', to: 'friends#index'
  post '/profile/friends', to: 'friends#create'
  resources :welcome, only: [:index, :show]
end
