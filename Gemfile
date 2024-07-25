source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.2.2"
gem "bootsnap", require: false
gem "bootstrap"
gem "importmap-rails"
gem "jbuilder"
gem "jquery-rails"
gem "mysql2", "~> 0.5"
gem "pry", "~> 0.14.2"
gem "puma", "~> 5.0"
gem "rails", "7.0.7"
gem "rails-ujs"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

gem "font-awesome-rails"
gem "sassc-rails"

group :development, :test do
  gem "debug", platforms: %i(mri mingw x64_mingw)
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
