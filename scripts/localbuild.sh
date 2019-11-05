#!/usr/bin/bash

docker-compose -f ../course-03/exercises/udacity-c3-deployment/docker/docker-compose-build.yaml build --parallel
docker-machine start default
docker-compose -f ../course-03/exercises/udacity-c3-deployment/docker/docker-compose.yaml up