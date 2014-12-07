Rails.application.routes.draw do
  Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get "kii_apis/hello"
  get "kii_apis/user_info/:token" => "kii_apis#user_info"
  get "kii_apis/object_data/:object_id" => "kii_apis#object_data"
  post "kii_apis/new_user"
  post "kii_apis/login/:user_name/:password" => "kii_apis#login"
  post "kii_apis/object"
  post "kii_apis/group_points"
end
