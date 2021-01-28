#!/bin/bash
RAILS_ENV=production bundle exec rake assets:precompile
git add . 
git commit -m 'production compiled assets for heroku assets pipeline'