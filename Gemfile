source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"
gem "sassc-rails"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "pg", "~> 1.4", ">= 1.4.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "dotenv-rails"
gem "devise", "~> 4.8", ">= 4.8.1"
gem "omniauth-google-oauth2", "~> 0.8.2"
gem "select2-rails"
gem "jquery-rails"
gem "kaminari"
gem "bootstrap5-kaminari-views"
gem "kaminari-i18n", "~> 0.5.0"
gem "image_processing"
gem "sidekiq"
gem "whenever", :require => false
gem "aws-sdk-s3", :require => false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot"
  gem "faker"
  # gem "rspec-rails", "~> 6.0.0.rc1"
  # gem "shoulda-matchers"
end

group :development do
  gem "web-console"
  gem "bullet"
end

group :production do
  gem "rails_12factor", "0.0.2"
  gem "faker"
  gem "image_processing"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end