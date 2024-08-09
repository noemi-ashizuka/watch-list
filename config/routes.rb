Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'lists#index'
  resources :lists, only: [:index, :show, :new, :create] do
    resources :bookmarks, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end

  resources :bookmarks, only: [:create]

  resources :movies, only: [:index]
  resources :bookmarks, only: :destroy

  get "/rankings", to: "lists#rankings", as: :rankings
end
