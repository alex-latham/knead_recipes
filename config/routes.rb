Rails.application.routes.draw do
  get 'next/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  resources :search, only: [:index, :create]

  resources :recipes, only: [:index]

  resources :welcome, only: [:index, :show]
end
