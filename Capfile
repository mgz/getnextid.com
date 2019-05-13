require 'recap/recipes/rails'

set :repository, 'git@github.com:mgz/getnextid.git'

task :release do
    set :branch, 'master'
    set :application, 'getnextid.com'
    server Rails.application.credentials.deploy_host, :app
end

task :beta do
    set :branch, 'beta'
    set :application, 'beta.getnextid.com'
    server Rails.application.credentials.deploy_host, :app
end


# before 'rails:db:migrate', :make_tag
before 'rails:db:migrate', :copy_overlays
after 'copy_overlays', :precompile

namespace :deploy do
    task :restart do
        as_app 'touch tmp/restart.txt'
        update_crontab
        make_tag
        send_rollbar_deploy
    end
end

task :copy_overlays do
    as_app 'if [ -d ../overlay ]; then rsync -q -a --no-perms --no-owner --no-group -I --no-times  ../overlay/ ./; fi'
end

task :update_crontab do
    as_app 'bundle exec whenever --update-crontab'
end

task :precompile do
    as_app 'bin/rake assets:precompile RAILS_ENV=production'
end

task :make_tag do
    `git tag deploy/#{application}/#{Time.now.strftime('%Y/%m/%d_%H-%M')} #{branch}`
end

task :send_rollbar_deploy do
    release = `curl -s -X POST "http://getnextid.com/counter/io.amsoft.getnextid.com.build?auth=#{Rails.application.credentials.build_number_increment_password}"`
    `sentry-cli --auth-token #{Rails.application.credentials.sentry_auth_token} releases --org amsoft new -p getnextid-com #{release}`
    `sentry-cli --auth-token #{Rails.application.credentials.sentry_auth_token} releases --org amsoft set-commits --auto #{release}`
end
