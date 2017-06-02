Rails.application.routes.draw do
  use_doorkeeper

  namespace :v1 do
    jsonapi_resources :users
    jsonapi_resources :books 
    jsonapi_resources :themes
    jsonapi_resources :theories
    jsonapi_resources :units
    jsonapi_resources :exercises
    jsonapi_resources :sentences
    jsonapi_resources :answers
  end
end
