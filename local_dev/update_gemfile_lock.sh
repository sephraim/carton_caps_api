#!/bin/bash

set -eu

docker compose run --no-deps --rm web bundle install
docker compose build