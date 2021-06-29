Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :update, :destroy, :show] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :update, :destroy, :show] do
    resources :notes, only: [:new]
  end

  resources :notes, only: [:create, :show, :edit, :update, :destroy]

  resource :session, only: [:create, :new, :destroy]

  


  root to: "users#index"
end
