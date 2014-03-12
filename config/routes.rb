Medialog::Application.routes.draw do
  resources :mlog_entries

  root 'mlog_entries#index'

  get 'search' => 'mlog_entries#search'
  
  post 'search' => 'mlog_entries#search_log'

end
