#!/bin/sh

# Para que funcione sin problemas NPM
#export NVM_DIR="/home/wecher/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


echo "ACTUALIZANDO REACT"
cd /home/wecher/Git/deploy-2248-dyj
git pull
npm run build


echo "ACTUALIZANDO PROLOG"
# Download the latest version of the image
docker pull matichewer/2248-dyj-prolog:latest

# Stop the running container
docker stop 2248-dyj

# Remove the stopped container
docker rm 2248-dyj

# Run a new container with the updated image
docker run -d -it -p 3031:3030 --name "2248-dyj" matichewer/2248-dyj-prolog:latest

