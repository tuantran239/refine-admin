#!/bin/sh

CI_DEPLOY_USER="${CI_DEPLOY_USER:-root}"
CI_DEPLOY_SSH_PORT="${CI_DEPLOY_SSH_PORT:-22}"
CI_DEPLOY_HOST="$CI_DEPLOY_USER@$CI_DEPLOY_SERVER"


# Copy necessary files to /app folder.
scp -o StrictHostKeyChecking=no -r -P $CI_DEPLOY_SSH_PORT \
  ./.env \
  ./docker-compose.staging.yml \
  ./deploy/scripts/setup_staging_app.sh \
  $CI_DEPLOY_HOST:/app

ssh -o StrictHostKeyChecking=no -p $CI_DEPLOY_SSH_PORT $CI_DEPLOY_HOST << 'ENDSSH' 
  set -e

  cd /app

  # Export environment variables from `/app/.env`
  export $(grep -v '^#' .env | xargs)

  # Login to the container registry.
  echo "$CI_REGISTRY_PASSWORD" | sudo docker login -u $CI_REGISTRY_USER

  # Set up application.
  ./setup_staging_app.sh

  # Clean up unused resources.
  sudo docker system prune --all --force &
ENDSSH
