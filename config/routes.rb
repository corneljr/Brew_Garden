Rails.application.routes.draw do

  get 'comments/index'

  get 'comments/create'

  mount Ckeditor::Engine => '/ckeditor'
  resources :pledges
  resources :sessions, :only => [:new, :create, :destroy]
	resources :users do 
    resources :comments
  end
  root to: "welcome#index"

  resources :projects do
  	resources :rewards, only: [:create, :destroy, :update, :show] do
  		resources :pledges, only: [:create, :show]
  	end
    resources :comments
  end
end
