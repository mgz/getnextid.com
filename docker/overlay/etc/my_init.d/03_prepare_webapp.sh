#!/usr/bin/env bash

cd /home/app/webapp
su app -c "bin/rake assets:precompile RAILS_ENV=production" || echo 'Failed'
su app -c "RAILS_ENV=production bin/rake db:migrate" || echo 'Failed'
