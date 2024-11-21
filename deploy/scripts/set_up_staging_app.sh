#!/bin/sh

# Main script to setup and start the application.
# This script is run on the remote server.

set -e

cd /app

export $(grep -v '^#' .env | xargs)

# Start application container(s).
sudo docker pull $CI_DEPLOY_IMAGE
sudo docker-compose -f docker-compose.staging.yml up -d