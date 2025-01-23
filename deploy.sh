#!/bin/bash

# Build your project
sh 'chmod +x build.sh'
sh './build.sh'

#Build Docker Container
docker-compose up -d
docker ps

#Docker login
docker login -u vishnu2naick -p dckr_pat_nm4fLXJHR-4bYLgnn7fgXYqFa-E

#Push image to Docker Hub
if [ $GIT_BRANCH == "origin/dev" ]; then

    docker tag mob_shop_project:v1 vishnu2naick/dev
    docker push vishnu2naick/dev

elif [ $GIT_BRANCH == "origin/main" ]|[$GIT_BRANCH == "origin/master"]; then
    sh 'chmod +x build.sh'
    sh './build.sh'

    docker tag mob_shop_project:v1 vishnu2naick/prod
    docker push vishnu2naick/prod
fi