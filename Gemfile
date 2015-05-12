source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.2'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass', '>= 3.0.0.0'
gem 'figaro'
gem 'pg'
gem 'kaminari'
gem 'openurl', '~> 1.0.0'
gem 'devise'
gem 'thin'

group :development do
  gem 'pry'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'therubyracer'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'annotate'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end

# Heroku-specific stuff
gem 'rails_12factor', group: :production
ruby '2.0.0'