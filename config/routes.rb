Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get 'cart_items/create'
      get 'cart_items/destroy'
      devise_for :users, controllers: {
         sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations'
      }
      resources :products, only: [:index, :show, :create, :update, :destroy] do
        member do
          patch :approve
          patch :decline
        end
      end
      resources :orders, only: [:index, :show, :create, :update, :destroy]
      resources :coupons, only: [:index, :show, :create, :update, :destroy]
      resources :cart_items, only: [:create, :destroy]
    end
  end
  
end
