Rails.application.routes.draw do
  root  'homes#top'
  get 'homes/about'

  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
} 

end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html