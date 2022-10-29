#!/bin/bash

set -eu

# Initialize the Carton Caps API

# Create local environment variables file
cp .env.example .env

# Create a MySQL database volume
docker volume create carton-caps-api-mysql

# Build application images
docker compose build

# Create the database (including schema and seed data)
docker compose run --rm web wait-for-it --strict --timeout=30 db:3306 -- bundle exec rails db:setup

# Stop remaining service(s) & destroy containers
docker compose down