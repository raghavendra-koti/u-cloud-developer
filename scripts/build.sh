#!/usr/bin/bash
#sudo rm /usr/local/bin/docker-compose
#curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
#chmod +x docker-compose
#sudo mv docker-compose /usr/local/bin
#docker-compose -f course-03/exercises/udacity-c3-deployment/docker/docker-compose-build.yaml build --parallel

VERSION=$2

if [ "$1" == "BUILD" -o "$1" == "DEPLOY" ] 
then
    docker -v 
    #&& docker-compose -v
    docker build -t udacity-restapi-feed course-03/exercises/udacity-c3-restapi-feed/.
    docker tag udacity-restapi-feed shaastra/udacity-restapi-feed:"$VERSION" 

    docker build -t udacity-restapi-user course-03/exercises/udacity-c3-restapi-user/.
    docker tag udacity-restapi-user shaastra/udacity-restapi-user:"$VERSION"
    
    docker build -t udacity-frontend course-03/exercises/udacity-c3-frontend/.
    docker tag udacity-frontend shaastra/udacity-frontend:"$VERSION"
    
    docker build -t reverseproxy course-03/exercises/udacity-c3-deployment/docker/.
    docker tag reverseproxy shaastra/reverseproxy:"$VERSION"
fi
