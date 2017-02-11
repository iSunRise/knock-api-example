# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'techid_backend'
set :repo_url, 'git@github.com:AlexZosik/techid_backend.git'

set :user, 'deepc'

set :branch, :master
set :deploy_to, '/var/www/techid_backend'
set :pty, false
set :linked_files, %w{config/database.yml .env config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/landing public/swagger public/apidocs}
set :keep_releases, 5
set :rvm_ruby_version, '2.3.2'

after 'deploy:published', 'deploy:generate_swagger_docs'

namespace :deploy do
  task :generate_swagger_docs do
    on roles(:all) do
      within release_path do
        with RAILS_ENV: 'production', SWAGGER: 'true' do
          execute :rake, 'swagger:docs'
        end
      end
    end
  end
end
