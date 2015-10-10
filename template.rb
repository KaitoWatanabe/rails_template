# Gemfile
gem_group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'quiet_assets'
  gem 'meta_request'
  gem 'bullet'
  gem 'annotate'
  gem "rails_best_practices"
end

gem 'devise'
gem 'acts-as-taggable-on'
gem 'impressionist'
gem 'slim-rails'
gem "font-awesome-rails"
gem 'kaminari'
gem 'jquery-turbolinks'
gem 'cancancan'
gem 'remotipart', '~> 1.2'
gem 'seed-fu', '~> 2.3'
gem 'ransack'
gem 'material_design_lite-rails'

# application
application 'config.i18n.default_locale = :ja'
application "config.time_zone = 'Tokyo'"

# development
bullet = <<CODE
config.after_initialize do
  Bullet.enable = true
  Bullet.alert = true
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.rails_logger = true
end
CODE
environment bullet, env: 'development'

# root
generate :controller, "home", "index"
route "root to: 'home#index'"

better_errors = <<'CODE'
if defined? BetterErrors
  BetterErrors.editor = proc { |file, line| "viminiterm://open?url=file://#{file}&line=#{line}" }
end
CODE
initializer('better_errors.rb', better_errors)

# create DB
rake "db:create"

after_bundle do
  run "gem install html2slim --no-ri --no-rdoc"
  run "erb2slim app/views/layouts/application.html.erb && rm app/views/layouts/application.html.erb"

  # devise
  run "bundle exec spring stop"
  generate 'devise:install'
  environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: 'development'
  generate 'devise:views'
  run "for file in app/views/devise/**/*.erb; do erb2slim $file ${file%erb}slim && rm $file; done"
  generate :devise, "User"
  rake "db:migrate"

  # annotate
  generate 'annotate:install'
end

file 'config/locales/ja.yml', <<-CODE
  ja:
    views:
      pagination:
        first: "&laquo;"
        last: "&raquo;"
        previous: "&lsaquo;"
        next: "&rsaquo;"
        truncate: "..."
CODE






