#!/bin/bash

# Build your project
sh './build.sh'


#Docker login
docker login -u vishnu2naick -p dckr_pat_nm4fLXJHR-4bYLgnn7fgXYqFa-E

echo "Branch:$GIT_BRANCH"

#Push image to Docker Hub
if [ "$GIT_BRANCH" == "origin/dev" ]; then

    docker tag mob_shop_project:v1 vishnu2naick/dev
    docker push vishnu2naick/dev

elif [ "$GIT_BRANCH" == "origin/main" ] || ["$GIT_BRANCH" == "origin/master"]; then

    docker tag mob_shop_project:v1 vishnu2naick/prod
    docker push vishnu2naick/prod

fi

#Build Docker Container
docker-compose up -d
docker ps