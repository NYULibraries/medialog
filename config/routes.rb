Medialog::Application.routes.draw do
  resources :mlog_entries

  root 'mlog_entries#index'
end
