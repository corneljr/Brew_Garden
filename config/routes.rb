Rails.application.routes.draw do

  resources :password_resets, :only => [:create, :edit, :update, :new]

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  mount Ckeditor::Engine => '/ckeditor'
  resources :pledges
  resources :sessions, :only => [:new, :create, :destroy]
	resources :users do 
    resources :comments
  end
  root to: "welcome#index"

  resources :projects do
    resources :updates
  	resources :rewards, only: [:create, :destroy, :update, :show] do
  		resources :pledges, only: [:create, :show]
  	end
    resources :comments
  end

  get '/projects/:project_id/backers', to: 'projects#backers', as: 'project_backers'
end
