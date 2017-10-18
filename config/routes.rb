Rails.application.routes.draw do

  resource :profile

  # resources :comments
  # resources :photos do
  #   resources :comments
  # end
  devise_for :users, controllers: { registrations: "registrations" }

resources :users, only: [:show, :update], controller: :profiles
  resources :photos do
    resources :comments
    member do
      put "like", to: "photos#upvote"
      put "dislike", to: "photos#downvote"
    end
  end

  get "home/index"

  root  'photos#index'

  # resources :photos, only: [:new, :create, :index, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
