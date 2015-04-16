Rails.application.routes.draw do

  get '/:language_id/lessons/new' => 'lessons#new', :as => 'new_lesson'

  post '/:language_id/lessons' => 'lessons#create', :as => 'language/lessons'

  get 'messages/create'
  get '/users/status/:id' => 'users#status', :as => 'users_status'

  post '/:language_id/:problem_id/rooms/:id/refresh' => 'rooms#refresh_users', :as => 'refresh_room_users'

  root 'users#show'

  resources :contact_forms, :only => [:new, :create]

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"} do
  end

  resources :users, :only => [:show]
  resources :languages, :only => [] do
    resources :problems, :only => [:index]
  end

  get '/:id/progress' => "user_progresses#show", :as => 'progress'
  post 'user_progresses/create', :as => 'create_user_progress'
  put 'user_progresses/update', :as => 'update_user_progress'

  post 'posts/:post_id/comments/new' => 'comments#create', :as => 'new/post/comment'
  delete 'posts/:post_id/comments/:id' => 'comments#destroy', :as => 'post/comment'

  get ':id' => 'languages#show', as: :language
  get ':language_id/:id' => 'problems#show', as: :language_problem

  get ':language_id/:problem_id/posts/new' => 'posts#new', :as => 'new/problem/post'
  post ':language_id/:problem_id/posts' => 'posts#create'
  get ':language_id/:problem_id/posts/:id' => 'posts#show', :as => 'problem/post'
  get ':language_id/:problem_id/posts' => 'posts#index', :as => 'problem/posts'
  delete 'posts/:post_id' => 'posts#destroy', :as => 'destroy/problem/post'

  get ':language_id/:problem_id/rooms/new' => 'rooms#new', :as=> 'new/problem/room'
  post ':language_id/:problem_id/rooms' => 'rooms#create'
  get ':language_id/:problem_id/rooms/:id' => 'rooms#show', :as => 'problem/room'

  get ':language_id/:problem_id/rooms' => 'rooms#index', :as => 'problem/rooms'

  post 'rooms/:room_id/messages/new' => 'messages#create', :as => 'new/room/message'


end
