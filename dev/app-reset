#!/bin/bash

set -u

# Reset the Carton Caps API so that ./init.sh can be run again

# Stop remaining service(s) & destroy containers
docker compose down

# Remove local environment variables file
rm .env

# Remove application image
docker image rm carton-caps-api-web

# Remove MySQL database volume
docker volume rm carton-caps-api-mysql