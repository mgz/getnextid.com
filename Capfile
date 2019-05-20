require 'recap/recipes/rails'

SENTRY_AUTH_TOKEN = '05ad563cb7684c839a8e93cc4d3b9836fe673fa0973d45d798b724d723ff29c5'

set :repository, 'git@github.com:mgz/getnextid.git'

task :release do
    set :branch, 'master'
    set :application, 'getnextid.com'
    server 'x2.gorod.lv', :app
end

task :beta do
    set :branch, 'beta'
    set :application, 'beta.getnextid.com'
    server 'x2.gorod.lv', :app
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
    # as_app 'curl https://api.rollbar.com/api/1/deploy/ -F access_token=0aa5dde3dec14b32a701b9180843dd7d -F environment=production -F revision=`git log -n 1 --pretty=format:"%H"` -F local_username=`whoami`'
    release = `curl -s -X POST "http://getnextid.com/counter/io.amsoft.getnextid.com.build?auth=zw87FpkC0snh"`
    `sentry-cli --auth-token #{SENTRY_AUTH_TOKEN} releases --org amsoft new -p getnextid-com #{release}`
    `sentry-cli --auth-token #{SENTRY_AUTH_TOKEN} releases --org amsoft set-commits --auto #{release}`
end
