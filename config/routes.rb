Rails.application.routes.draw do

  resources :password_resets

  get '/projects/location_search', to: 'projects#location_search'
  get '/projects/all_near', to: 'projects#near_location'

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  mount Ckeditor::Engine => '/ckeditor'
  resources :pledges
  resources :sessions, :only => [:new, :create, :destroy]
	resources :users do
    resources :comments, except: [:index]
  end

  get '/projects/:id/post', to: 'projects#post', as: 'post_project'
  get 'projects/past', to: 'projects#past_projects', as: 'past_projects'

  resources :projects do
    resources :slider_images, only: [:create]
    resources :updates
  	resources :rewards, only: [:create, :destroy, :update, :show] do
  		resources :pledges, only: [:create, :show]
      resources :charges, only: [:new, :create]
  	end
    resources :comments
  end

  get '/projects/:project_id/backers', to: 'projects#backers', as: 'project_backers'
  get '/search', to: 'projects#search', as: 'project_search'
  get '/projects/category/:category', to: 'projects#category', as: 'project_category'

  get '/users/:id/backed', to: 'users#pledges', as: 'user_pledges'
  get '/users/:id/created', to: 'users#projects', as: 'user_projects'
  get '/users/:id/comments', to: 'users#comments'

  post '/contact', to: 'welcome#contact', as: 'welcome_contact'
  root to: 'welcome#index'

end