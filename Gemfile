source 'https://rubygems.org'

gem 'rails', '~> 4.1.11'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# For SysAid support
gem 'sysaid', '>= 0.3.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'jasmine-rails'
end

gem 'capistrano', '< 3.0.0', group: :development

group :production do
  gem 'pg'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'

# Provides authorization layer
gem 'declarative_authorization', :git => 'https://github.com/stffn/declarative_authorization.git'

gem 'activerecord-session_store'
