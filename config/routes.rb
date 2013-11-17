Dummy::Application.routes.draw do
  get "home/index"
  devise_for :users
  resources :projects do
    resources :donations, shallow: true
  end
  resources :updates
  

   root 'home#index'
end
