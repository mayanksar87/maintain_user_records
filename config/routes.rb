Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :daily_records
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
