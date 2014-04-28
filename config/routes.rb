Medialog::Application.routes.draw do
  resources :mlog_entries

  root 'mlog_entries#index'

  get 'search' => 'mlog_entries#search'
  
  post 'results' => 'mlog_entries#results'
  get 'results' => 'mlog_entries#results'
  
  get 'mlog_entries/:id/clone' => 'mlog_entries#clone'

end
