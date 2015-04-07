Rails.application.routes.draw do
  root 'users#show'
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"}

  resources :users, :only => [:show]
  resources :languages, :only => [] do
    resources :problems, :only => [:index]
  end
  
  get '/:id/progress' => "user_progresses#show", :as => 'progress'
  post 'user_progresses/create', :as => 'create_user_progress'
  put 'user_progresses/update', :as => 'update_user_progress'

  get ':id' => 'languages#show', as: :language
  get ':language_id/:id' => 'problems#show', as: :language_problem

end
