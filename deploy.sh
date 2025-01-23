#!/bin/bash

#Build Docker Container
docker-compose up -d
docker ps

#Docker Hub repository name and Image Tags with version
docker tag mob_shop_project:v1 vishnu2naick/prod
docker tag mob_shop_project:v1 vishnu2naick/dev

#Docker login
docker login -u vishnu2naick -p dckr_pat_nm4fLXJHR-4bYLgnn7fgXYqFa-E

#Push image to Docker Hub
docker push vishnu2naick/prod
docker push vishnu2naick/dev