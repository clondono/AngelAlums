Dummy::Application.routes.draw do

  get "home/index"
  devise_for :users
  resources :projects do
    resources :donations, shallow: true
    resources :updates, shallow: true
  end
   root 'home#index'
end
