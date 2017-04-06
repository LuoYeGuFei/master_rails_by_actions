Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products
  end
end
