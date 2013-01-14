PadOnRails::Application.routes.draw do
  
  resources :opportunities

  devise_for :users, :controllers => {:sessions => 'devise/sessions', :registrations => 'devise/registrations', :passwords => 'devise/passwords'}, :skip => [:sessions] do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  root :to => 'users#index'
  
  match 'users/:user_id/projects(.:format)' => 'statistics#get_time_entries', :as => :user_projects_time_entries
  match '/selector' => 'users_projects#selector'
  get '/users_projects/selector' => 'users_projects#selector'
  post '/users_projects/selector' => 'users_projects#choose'

  resources :users_projects
  resources :users
  resources :project_tasks
  resources :efforts
  
  resources :contacts do
  resources :comments
  end

  resources :companies do
  resources :comments
  end
  
  resources :projects do
  resources :project_tasks
  end

  get "timesheet/index"
  get "projects/new"
  get "usermanagement/index"
  get "projects/index"
  get "projects/editTasks"
  get "/projects/new"
  get "companies/new"
  get "statistics/index"

  match '/new_project' => 'projects#new'
  match '/projects/new' => 'projects#new'
  match '/companies' => 'companies#index'
  match '/company/new' => 'companies#new'
  match '/contacts' => 'contacts#index'
  match '/contacts/new' => 'contacts#new'
  match '/crm' => 'companies#index'
  match '/CRM' => 'companies#index'
  match '/statistics' => 'statistics#index'
  match '/new_project' => 'projects#new'
  match '/companies' => 'companies#index'
  match '/company/new' => 'companies#new'
  match '/contacts' => 'contacts#index'
  match '/contacts/new' => 'contacts#new'
  match '/crm' => 'companies#index'
  match '/CRM' => 'companies#index'
  match '/addtimesheettask/:id/:user_id' => 'project_tasks#addtimesheettask', :as => 'addtimesheettask'
  match '/deletetimesheettask/:user_id/:wc/:task_id' => 'project_tasks#deletetimesheettask', :as => 'deletetimesheettask'
  match '/project_tasks_show' => 'project_tasks#show'
  match '/project_tasks_new' => 'project_tasks#new'
  match '/project_tasks_index' => 'project_tasks#index'
  match '/login' => 'devise/sessions#new'
  match '/dashboard' => 'dashboard#index'
  match '/projects' => 'projects#index'
  match '/statistics' => 'statistics#index'
  match '/statistics/:id' => 'statistics#projectstats', :as => 'statistics_project'
  match '/range' => 'statistics#range'
  match '/edit_tasks' => 'projects#editTasks'
  match '/managerlist' => 'users#project_list'
  match '/positionlist' => 'contacts#position_list'
  match '/editTasks/:id' => 'projects#editTasks', :as => 'editTasks'
  match '/tasklist/:id' => 'projects#task_list', :as => 'tasklist'
  match '/edit_project_tasks/:id' => 'project_tasks#edit', :as => 'edit_project_tasks'
  match '/create' => 'users#new'
  match '/usermanagement' => 'usermanagement#index'
  match '/submiteffort' => 'timesheet#submit'
  match '/timesheet/showalltasks' => 'timesheet#showalltasks'
  match '/password/:id' => 'users#password', :as => 'password'
  match '/timesheet' => 'timesheet#index'
  match '/timesheet/:id' => 'timesheet#index'
  match '/timesheet/:id/:wc' => 'timesheet#index'
  match '/users/:id' => 'users#show'
  match '/presales' => 'statistics#presales'
  match '/change_password/:id' => 'users#change_password', :as => 'change_password'
  put '/change_password/:id' => 'users#update_password'
  match '/update_password' => 'users#update_password'
  match '/users_projects/:id' => 'users_projects#index', :as => 'users_projects'
  match '/submitusers_projects' => 'users_projects#submit'
end
