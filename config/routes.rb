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

  get 'mlog_entries/:id/json' => 'mlog_entries#mlog_json'

  post 'create_user' => 'users#create', as: :create_user

  get 'password' => 'users#reset_password'

  post 'password' => 'users#update_password', as: :update_password

  get 'reports' => 'reports#index' 

  get 'reports/format' => 'reports#format'

  get 'reports/format/:type' => 'reports#type'  

  namespace :api, constraints: { format: 'json' } do
    namespace :v0 do
      get :accession
    end
  end  
end
