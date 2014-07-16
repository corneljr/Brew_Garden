Rails.application.routes.draw do

  resources :pledges
  resources :sessions, :only => [:new, :create, :destroy]
	resources :users
  root to: "welcome#index"

  resources :projects do
  	resources :rewards, only: [:create, :destroy, :update, :show] do
  		resources :pledges, only: [:create, :show]
  	end
  end
end
