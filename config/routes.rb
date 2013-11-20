Dummy::Application.routes.draw do

  get "home/index"
  devise_for :users, :controllers => { registrations: "registrations" }
  resources :users
  resources :search
  resources :projects do
    resources :donations, shallow: true
    resources :updates, shallow: true
  end
   root 'home#index'
end
