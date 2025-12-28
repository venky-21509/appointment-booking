#require "sidekiq/web"
Rails.application.routes.draw do
 # mount sidekiq::web => "/sidekiq"


  resources :users
  get "home/index"
  devise_for :customers, controllers: { sessions: 'customers/sessions' }
  #devise_for :customers, skip: :all
  resources :appointments do
  member do
    patch :confirm
    patch :complete
    patch :receive
    patch :cancel
  end
end

namespace :api, defaults: {format: :json } do 
resources :appointments, only: [:index, :show, :create, :update, :destroy]
end

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
