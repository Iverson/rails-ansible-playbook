# rails-ansible-playbook
Ansible playbook for setup Rails application environment: ruby-2.1.5, deploy user, nginx, postgresql-9.3, nodejs, puma.

## Base settings

```
cp vars/defaults.example.yml vars/defaults.yml
```
then in `vars/defaults.yml` replace `app_name` param with your application name.

## Setup localy with Vagrant

```
vagrant up
```

then you can check out that all dependencies installed:

```
ssh deploy@127.0.0.1 -p 2200
ruby -v
node -v
psql --version
psql app_{{app_name}}
\q
exit
```

## Deploy app to vagrant as production server.

```
cp config/deploy.rb /your/rails-app/config/deploy.rb
```

add to Gemfile:

```
gem 'capistrano',         require: false
gem 'capistrano-rails',   require: false
gem 'capistrano-bundler', require: false
gem 'capistrano3-puma',   require: false
```

run bundler

```
bundle install
cap install
```

add to  `Capfile`

```
require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/puma'
```

open `config/deploy/production.rb` and define in  params:

```
server '127.0.0.1', user: 'deploy', port: 2200, roles: [:web, :app, :db], primary: true
set :branch, ENV['BRANCH'] || 'your-production-branch-name'
```

then run deploy

```
cap production deploy:check
cap production deploy
```

## Setup remote server

Create inventory file `hosts` and run: 

```
ansible-playbook -i hosts playbook.yml
```

## Deploy app to remote production server.

Same as vagrant.

