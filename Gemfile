source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"

gem "activerecord-import"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap", "~> 4.5", ">= 4.5.2"
gem "bootstrap4-kaminari-views", "~> 1.0", ">= 1.0.1"
gem "cancancan"
gem "carrierwave", "~> 2.1"
gem "cocoon", "~> 1.2", ">= 1.2.14"
gem "config"
gem "devise"
gem "devise-async"
gem "faker"
gem "figaro"
gem "file_validators"
gem "font-awesome-sass", "~> 5.13.0"
gem "i18n-js"
gem "jbuilder", "~> 2.7"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick", ">= 4.9.5"
gem "mysql2", "~>0.5.2"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"
gem "rails-i18n"
gem "ransack"
gem "roo", "~> 2.8.0"
gem "sass-rails", ">= 6"
gem "sidekiq"
gem "sprockets-rails", "2.3.3"
gem "toastr-rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"
gem "whenever", require: false

group :development, :test do
  gem "bundle-audit"
  gem "factory_bot_rails"
  gem "pry"
  gem "rails-controller-testing"
  gem "rails_best_practices"
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner-active_record"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
