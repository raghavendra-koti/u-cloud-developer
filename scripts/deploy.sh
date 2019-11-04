#!/usr/bin/bash
ACTION=$1
VERSION=$2

if [ $TRAVIS_PULL_REQUEST != "false" ]
then
    exit 0
fi

if [ $ACTION != "DEPLOY" ]
then
    echo "Nothing to deploy"
    exit 0
fi

VERSION = $2

docker login -u "$DOCKER_USER" -p "$DOCKER_PASSWORD"

docker push shaastra/udacity-restapi-feed:"$VERSION" 
docker push shaastra/udacity-restapi-user:"$VERSION" 
docker push shaastra/udacity-frontend:"$VERSION" 
docker push shaastra/reverseproxy:"$VERSION"