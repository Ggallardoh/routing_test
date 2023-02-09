Rails.application.routes.draw do
  devise_for :users
  root 'routes#index'

  resources :quotes, only: :index
end
