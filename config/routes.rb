Rails.application.routes.draw do
  root  'homes#top'
  get 'homes/about'
  

  resources :post_user, only: [:new, :create, :index, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resources :users, only: [:show, :edit, :update]
end