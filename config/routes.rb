Rails.application.routes.draw do
  devise_for :users
  root 'routes#index'

  resources :routes, only: %i[index] do
    put :assign
  end
end
