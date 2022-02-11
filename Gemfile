# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

##backend
gem 'action_policy', '~> 0.6.0'
gem 'bcrypt'
gem 'blueprinter', '~> 0.25.3'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'dry-equalizer', '~> 0.3.0'
gem 'dry-validation', '~> 1.6.0'
gem 'faker'
gem 'pagy', '~> 4.11'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sidekiq', '~> 6.2.1'
gem 'rswag-api'
gem 'rswag-ui', '~> 2.4'
gem 'multi_json', '~> 1.15'

## frontend
gem 'jbuilder', '~> 2.7'
gem 'react_on_rails'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
  gem 'rswag-specs'
  gem 'database_cleaner'
  gem 'factory_bot', '~> 6.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', '~> 1.20.0 ', require: false
  gem 'rubocop-performance', '~> 1.11', require: false
  gem 'rubocop-rails', '~> 2.11', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
