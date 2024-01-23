source 'https://rubygems.org'

gem 'rails', '3.2.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '~> 0.18.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'
  gem 'execjs', '<= 2.7.0' # Ejemplo, ajusta a la versión apropiada


  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'rubocop', group: 'development', require: false
gem 'rails-erd', group: :development

# required for sidekiq to function
gem 'sinatra', '~> 1.4'
gem "connection_pool", "= 2.1.0" # https://github.com/sidekiq/sidekiq/tree/v2.17.8
gem 'sidekiq', "= 2.17.8" # https://github.com/sidekiq/sidekiq/tree/v2.17.8
gem 'rufus-scheduler', "= 3.1" # required for sidekiq-cron
gem "sidekiq-cron" # https://github.com/sidekiq-cron/sidekiq-cron/tree/v0.1.6

gem "paperclip"
gem "audited-activerecord", "~> 3.0" # https://github.com/collectiveidea/audited/tree/v3.0.0

gem 'ransack', '~> 1.3.0'
gem 'kaminari'

group :development, :test do
  gem 'rspec-rails', '~> 3.9.1'
end

group :development do
  gem 'annotate'
end

#gem 'bullet', group: 'development'
gem 'grape', "= 0.16.2"
gem 'grape-swagger', "= 0.20.3"
gem "devise" # https://github.com/heartcombo/devise/tree/v2.2
gem 'jwt'

gem "interactor-rails"
gem 'simple_enum' # https://github.com/lwe/simple_enum/tree/v1.6.9
gem "debugger"
gem 'rack-cors', require: 'rack/cors'





