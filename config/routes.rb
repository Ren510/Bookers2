Rails.application.routes.draw do
  root  'homes#top'
  get 'homes/about'
  resources :books

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resources :users
end