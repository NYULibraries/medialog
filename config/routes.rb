Medialog::Application.routes.draw do
  
  devise_for :users
  resources :users, except: :create
  resources :mlog_entries
  resources :collections
  resources :accessions

  root 'mlog_entries#index'

  get 'media/:id' => 'mlog_entries#media'
  
  get 'repository/:repository_code' => 'collections#repository', as: :show_repository
  
  get 'nav/' => 'mlog_entries#nav'

  get 'mlog_entries/:id/clone', to: 'mlog_entries#clone', as: :clone_mlog_entry

  get 'collections/:id/uuid/' => 'collections#uuids'

  get 'mlog_entries/:id/json' => 'api/v0#mlog_entry'
  
  post 'create_user' => 'users#create', as: :create_user

  get 'password' => 'users#reset_password'

  post 'password' => 'users#update_password', as: :update_password

  get 'reports' => 'reports#index' 

  get 'reports/format' => 'reports#format'

  get 'reports/format/:type' => 'reports#type'  

  get 'api/v0/accession/:id' => 'api/v0#accession'

  get 'api/v0/mlog_entry/:id' => 'api/v0#mlog_entry'

end
