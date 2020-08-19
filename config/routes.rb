Rails.application.routes.draw do

   devise_for :admins
  
  devise_for :customers
  root 'home#top'
  get 'home/about', to: 'home#about'
  get '/products', to: 'products#index'
  resources :customers,only: [:show,:index,:edit,:update,:hide,:delete]
  resources :cart_items,only: [:create,:index,:destroy_all,:destroy,:update]
  resources :orders,only: [:new,:confirm,:create,:thank,:index,:show]
  resources :destinations,only: [:index,:create,:destroy,:edit,:update]


  namespace :admin do
    get 'home/top', to: 'home#top'
    resources :customers,only: [:show,:index,:edit,:update]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :products,only: [:index,:new,:create,:edit,:update,:show]
    resources :order_details,only: [:update]
    resources :orders,only: [:index,:show,:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
