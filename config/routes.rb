Dummy::Application.routes.draw do

  get "home/index"
  devise_for :users, :controllers => { registrations: "registrations" }
  resources :users
  resources :search
  resources :projects do
    resources :donations, shallow: true
    resources :updates, shallow: true do
    	resources :comments, :only => [:create, :destroy]
    end
  end

   root 'home#index'

  # Set up a routing for the destroy_all method
  #match "notes" => 'notes#destroy_all', :via => [:delete]

  # Create connections
  match 'admin', to: 'admin#admin', as: 'admin', :via => [:get]
  match 'admin_post', to: 'admin#admin_post', as: 'admin_post', :via => [:post]

end
