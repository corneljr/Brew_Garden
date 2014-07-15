Rails.application.routes.draw do

  resources :pledges
  resources :sessions, :only => [:new, :create, :destroy]
	resources :users
  root to: "welcome#index"
end
