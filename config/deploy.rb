# install rails3 with passenger gem
require 'bundler/capistrano'
# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

# cap deploy:setup
# cap deploy:cold
# cap deploy



set :app_name, "questionr"

set :rails_env, 'production'
set :domain, 'vps1800.directvps.nl'
set :user, 'deploy'

set :repository,  "git@github.com:memocom/#{app_name}.git"
set :branch, "master"

set :scm, :git
set :deploy_to, "/srv/production/#{app_name}"
set :ssh_options, {:paranoid => true}

default_run_options[:pty] = true

set :spinner, false
set :runner,'peterderuijter'
set :use_sudo, true

role :web, domain                        # Your HTTP server, Apache/etc
role :app, domain                        # This may be the same as your `Web` server
role :db,  domain, :primary => true      # This is where Rails migrations will run

namespace :mod_rails do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
    #run "cd #{current_path} && bash restart.sh"
  end
end

namespace :deploy do
  desc "Link shared database.yml to shared"
  task :database_shared do
    unless File.exists?("#{shared_path}/database.yml")
      run "mv #{release_path}/config/database.yml #{shared_path}/database.yml"
    else
      run "rm #{release_path}/config/database.yml"
    end
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end


namespace :deploy do
  desc "Precompile assets for Rails 3.x pipeline"
  task :compile_assets do
    run "cd #{release_path} && bundle exec rake assets:precompile --trace RAILS_ENV=production"
  end
end
namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do

    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end
namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
end

namespace :bundle do
  desc "Update bundle"
  task :update, :roles => :app do
    run "cd #{current_path} && bundle install"
  end
end

namespace :deploy do
  desc "Create User"
  task :initialize_app do
    run "rake app:initialize -RAILS_ENV=production"
  end
end

namespace :deploy do
  task :set_environment_var do

    default_environment['MYSQL_PASSWORD'] = run "bash -c 'source /etc/profile && echo $MYSQL_PASSWORD'"
    puts ENV['MYSQL_PASSWORD']
  end
end



namespace :deploy do

    namespace :db do

      desc <<-DESC
        Creates the database.yml configuration file in shared path.

        By default, this task uses a template unless a template \
        called database.yml.erb is found either is :template_dir \
        or /config/deploy folders. The default template matches \
        the template for config/database.yml file shipped with Rails.

        When this recipe is loaded, db:setup is automatically configured \
        to be invoked after deploy:setup. You can skip this task setting \
        the variable :skip_db_setup to true. This is especially useful \
        if you are using this recipe in combination with \
        capistrano-ext/multistaging to avoid multiple db:setup calls \
        when running deploy:setup for all stages one by one.
      DESC
      task :setup, :except => { :no_release => true } do

        default_template = <<-EOF
        base: &base
          adapter: mysql
          timeout: 5000
          user: root
          password: #{ENV['MYSQL_PASSWORD']}
        development:
          database: #{app_name}_development
          <<: *base
        test:
          database: #{app_name}_test
          <<: *base
        production:
          database: #{app_name}_production
          <<: *base
        EOF

        location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
        template = File.file?(location) ? File.read(location) : default_template

        config = ERB.new(template)

        run "mkdir -p #{shared_path}/db"
        run "mkdir -p #{shared_path}/config"
        put config.result(binding), "#{shared_path}/config/database.yml"
      end

      desc <<-DESC
        [internal] Updates the symlink for database.yml file to the just deployed release.
      DESC
      task :symlink, :except => { :no_release => true } do
        run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      end

    end

    after "deploy:setup",           "deploy:db:setup"   unless fetch(:skip_db_setup, false)
    after "deploy:finalize_update", "deploy:db:symlink"

  end

before 'deploy:migrate', 'deploy:set_environment_var'
after 'deploy:update_code', "deploy:database_shared", 'deploy:symlink_shared'#,  'deploy:compile_assets'
