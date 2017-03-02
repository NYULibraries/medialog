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

  post 'mlog_entries/lookup' => 'mlog_entries#lookup'

  post 'collections/lookup' => 'collections#lookup'

  post 'accessions/lookup' => 'accessions#lookup'

  get 'mlog_entries/:id/clone', to: 'mlog_entries#clone', as: :clone_mlog_entry

  get 'collections/:id/uuid/' => 'collections#uuids'

  get 'mlog_entries/:id/json' => 'api/v0#mlog_entry'

  post 'create_user' => 'users#create', as: :create_user

  get 'admin', to: 'users#admin', as: :admin_path

  get 'password' => 'users#reset_password'

  post 'password' => 'users#update_password', as: :update_password

  post 'users/destroy' => 'users#destroy'

  post 'users/make_admin' => 'users#make_admin'

  # devise_for :users, :controllers => { :registrations => 'users/registrations' }

  get 'reports' => 'reports#index' 

  get 'reports/format' => 'reports#format'

  get 'reports/format/:type' => 'reports#type'  

  get 'api/v0/accession/:id' => 'api/v0#accession'

  get 'api/v0/mlog_entry/:id' => 'api/v0#mlog_entry'

  get 'api/v0/collection/:id' => 'api/v0#collection'

  get 'api/v0/collection/:code/find' => 'api/v0#collection_find'

end
