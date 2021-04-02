Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cats do
    resources :toys, only: [:index, :new]
  end

  resources :toys, only: [:show, :update, :destroy, :create]

  root to: redirect("/cats")
end
