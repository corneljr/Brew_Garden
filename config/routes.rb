Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :pledges
  resources :sessions, :only => [:new, :create, :destroy]
	resources :users
  root to: "welcome#index"

  resources :projects do
    resources :updates, only: [:create, :destroy, :new, :edit]
  	resources :rewards, only: [:create, :destroy, :update, :show] do
  		resources :pledges, only: [:create, :show]
  	end
  end
end
