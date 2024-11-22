#!/bin/sh

set -e

echo "# Starting additional CI variables" >> .env

echo $CI_DEPLOY_ENV_VARS | base64 -d >> .env

echo $CI_DEPLOY_PRIVATE_KEY

# mkdir -p ~/.ssh
# cp $CI_DEPLOY_PRIVATE_KEY ~/.ssh/id_rsa
# chmod 600 ~/.ssh/id_rsa
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa  
