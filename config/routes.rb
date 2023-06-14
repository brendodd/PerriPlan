Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :hotels do
    resources :id, only: [:show]
    resources :bookings, only: [:new, :create]
  end
  # Defines the root path route ("/")
  # root "articles#index"
  resources :bookings, only: [:show] do
    resources :reviews, only: [:new, :create]
  end
  resources :cities, only: [:show]
  resources :restaurants, only: [:show] do
    resources :bookings, only: [:new, :create]
  end

  resources :attractions, only: [:show]
end
