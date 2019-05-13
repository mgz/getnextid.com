require 'recap/recipes/rails'

set :repository, 'git@github.com:mgz/getnextid.git'

task :release do
    set :branch, 'master'
    set :application, 'gentextid.com'
    server 'x2.gorod.lv', :app
end

task :beta do
    set :branch, 'beta'
    set :application, 'beta.getnextid.com'
    server 'x2.gorod.lv', :app
end


# before 'rails:db:migrate', :make_tag
before 'rails:db:migrate', :copy_overlays

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

task :make_tag do
    `git tag deploy/#{application}/#{Time.now.strftime('%Y/%m/%d_%H-%M')} #{branch}`
end

task :send_rollbar_deploy do
    revision = `git log -n 1 --pretty=format:"%H"`
    # as_app 'curl https://api.rollbar.com/api/1/deploy/ -F access_token=0aa5dde3dec14b32a701b9180843dd7d -F environment=production -F revision=`git log -n 1 --pretty=format:"%H"` -F local_username=`whoami`'
    s = <<-EOF
curl https://sentry.io/api/0/organizations/amsoft/releases/ \
-X POST \
-H 'Authorization: Bearer 6274301663934f1ba123e05da9a628f85c32390e971f41d88a720c32ca3de878' \
-H 'Content-Type: application/json' \
-d '
{
"version": "#{revision}",
"refs": [{
"repository":"mgz/getnextid",
"commit":"#{revision}"
}],
"projects":["getnextid.com"]
}
'
    EOF
    `#{s}`

end
