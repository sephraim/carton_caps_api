#!/bin/bash

set -eu

bundle exec bin/rails db:create
bundle exec bin/rails db:migrate
bundle exec bin/rails server -p 3000 -b 0.0.0.0
