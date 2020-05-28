Rails.application.routes.draw do
  get 'next/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  resources :welcome, only: [:index, :show]
end
