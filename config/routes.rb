Rails.application.routes.draw do
  root  'homes#top'
  get 'home/about'=>'homes#about'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする  
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  resources :books
  
  resources :relationships, only: [:create, :destroy]
  
  resources :books, only: [:new, :edit, :create, :index, :show, :destroy] do
  resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  
end