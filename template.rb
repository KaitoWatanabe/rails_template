# Gemfile
gem_group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'quiet_assets'
end

gem 'devise'
gem 'acts-as-taggable-on'
gem 'impressionist'
gem 'slim-rails'
gem "font-awesome-rails"
gem 'kaminari'
gem 'jquery-turbolinks'
gem 'cancancan'

# application
application 'config.i18n.default_locale = :ja'

# root
generate :controller, "home", "index"
route "root to: 'home#index'"

# devise
after_bundle do
  run "bundle exec spring stop"
  generate 'devise:install'
  environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'development'
  generate 'devise:views'
  generate :devise, "User"
  rake "db:migrate"
end


