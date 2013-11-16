Dummy::Application.routes.draw do
  get "home/index"
  devise_for :users
  resources :projects
  resources :updates

   root 'home#index'
end
