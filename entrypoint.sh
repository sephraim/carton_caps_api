#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid
# that prevents the server from running
rm -f /app/tmp/pids/server.pid

# Execute the container's main process
# (what's set as CMD in the Dockerfile)
exec "$@"