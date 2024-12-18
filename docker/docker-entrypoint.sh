#!/bin/sh

set -x

bundle exec rails tmp:clear

bundle exec rails assets:precompile RAILS_ENV=production

 # Permissions
chmod -R 777 tmp
chmod -R 777 log

puma
