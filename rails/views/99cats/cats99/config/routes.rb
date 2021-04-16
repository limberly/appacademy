Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cats
  resources :cat_rental_requests
    post '/cat_rental_requests/approve', to: 'cat_rental_requests#approve!', as: 'approve_cat_rental_request'
    
    post '/cat_rental_requests/deny', to: 'cat_rental_requests#deny!', as: 'deny_cat_rental_request'
end
