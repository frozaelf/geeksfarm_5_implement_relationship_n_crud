 set :domain, "<username@address_domain>"

role :app, domain

role :web, domain

role :db, domain

set :deploy_to, '/path/in/staging/for/put/app'

set :rails_env, 'staging'

require "capistrano-rbenv"

set :rbenv_type, :user # or :system, depends on your rbenv setup

set :rbenv_ruby, '2.0.0-p598'