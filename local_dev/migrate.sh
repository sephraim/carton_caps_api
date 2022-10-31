#!/bin/bash

set -eu

# Migrate the database

# Create the database (including schema and seed data)
docker compose run --rm web wait-for-it --strict --timeout=30 db:3306 -- bundle exec rails db:migrate

# Stop remaining service(s) & destroy containers
docker compose down
