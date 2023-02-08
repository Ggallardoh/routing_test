Rails.application.routes.draw do
  root 'routes#index'

  resources :quotes, only: :index
end
