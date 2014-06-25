Medialog::Application.routes.draw do
  resources :mlog_entries

  root 'mlog_entries#index'

  get 'search' => 'mlog_entries#search'
  
  post 'results' => 'mlog_entries#results'
  
  get 'results' => 'mlog_entries#results'
  
  get 'repository/:repo' => 'mlog_entries#repository'

  get 'accession/' => 'mlog_entries#accession'

  get 'collection/:collection_code' => 'mlog_entries#collection'
  
  get 'nav/' => 'mlog_entries#nav'

  get 'mlog_entries/:id/clone', to: 'mlog_entries#clone', as: :clone_mlog_entry
  
end
