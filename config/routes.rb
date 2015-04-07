Rails.application.routes.draw do
  get 'user_progresses/create'

  get 'user_progresses/update'

  get 'problems/index'

  get 'problems/show'

  get 'comments/create'

  get 'comments/update'

  get 'comments/destroy'

  get 'posts/show'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

  get 'posts/new'

  get 'posts/create'

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"}
  resources :users 
  resources :languages 
  root 'users#show'
end
