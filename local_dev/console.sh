#!/bin/bash

set -eu

# Run the Rails console

# Create container & shell into a Rails console session
docker compose run --rm web wait-for-it --strict --timeout=30 db:3306 -- bundle exec rails console