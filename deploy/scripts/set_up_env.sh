#!/bin/sh

set -e

echo "# Starting additional CI variables" >> .env

echo $CI_DEPLOY_ENV_VARS | base64 -d >> .env

echo $CI_DEPLOY_PRIVATE_KEY

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "tuanphamtran99@gmail.com" -f ~/.ssh/id_ed25519 -P ""
cd ~/.ssh
echo $CI_DEPLOY_PRIVATE_KEY > id_ed25519
chmod 600 ~/.ssh/id_ed25519
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa
cd ~
