#!/usr/bin/bash

VERSION=$1

sed -i "s/\$VERSION/${VERSION}/" ../course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
sed -i "s/\$DEPLOYMENT_NAME/feedback-BETA/" ../course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
sed -i "s/replicas:.*/replicas: 1/" ../course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
