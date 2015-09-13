# Gemfile
gem_group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

gem 'devise'
gem 'acts-as-taggable-on'
gem 'carrierwave', github:'carrierwaveuploader/carrierwave'
gem "mini_magick"
gem 'impressionist'
gem 'fog'
gem 'slim-rails'
gem "font-awesome-rails"
gem 'kaminari'
gem 'jquery-turbolinks'

# application
application 'config.i18n.default_locale = :ja'

# root
generate :controller, "home", "index"
route "root to: 'home#index'"

# devise
generate ':devise:install'
environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'development'
generate ':devise:views'
generate :devise, "User"
rake "db:migrate"

