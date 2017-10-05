Rails.application.routes.draw do
  resources :photos
  devise_for :users
  root to: 'home#landing'

  # resources :photos, only: [:new, :create, :index, :edit, :update]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
