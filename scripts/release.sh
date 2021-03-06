 #!/usr/bin/bash
ACTION=$1
VERSION=$2
BETA=""

if [ $TRAVIS_PULL_REQUEST != "false" ]
then
    exit 0
fi

sudo chmod +x ./scripts/kill-beta.sh

if [ $ACTION == "RELEASE" -o $ACTION == "RELEASE-BETA" -o $ACTION == "PROMOTE" -o $ACTION == "ROLLBACK" -o $ACTION == "ROLLBACK-BETA" ]
then

    sudo chmod +x ./scripts/prepare-release.sh
    ./scripts/prepare-release.sh
    
    if [ $ACTION == "ROLLBACK" ]
    then
        echo "Setting rollback version"
        VERSION=$3
        echo "VERSION = ${VERSION}"
    fi

    if [ $ACTION == "RELEASE-BETA" ]
    then
        BETA="-beta"

        sed -i "s/replicas.*/replicas: 1/g" course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
        sed -i "s/replicas.*/replicas: 1/g" course-03/exercises/udacity-c3-deployment/k8s/backend-feed-deployment.yaml
        sed -i "s/replicas.*/replicas: 1/g" course-03/exercises/udacity-c3-deployment/k8s/frontend-deployment.yaml
        sed -i "s/replicas.*/replicas: 1/g" course-03/exercises/udacity-c3-deployment/k8s/reverseproxy-deployment.yaml
    fi 

    if [ $ACTION == "ROLLBACK-BETA" ]
    then  
        ./scripts/kill-beta.sh
        exit 0
    fi

    if [ $ACTION == "PROMOTE" ]
    then
        ./scripts/kill-beta.sh
    fi


    sed -i "s/\$DEPLOYMENT_NAME/backend-user${BETA}/g" course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
    sed -i "s/\$VERSION/${VERSION}/g" course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml

    sed -i "s/\$DEPLOYMENT_NAME/backend-feed${BETA}/g" course-03/exercises/udacity-c3-deployment/k8s/backend-feed-deployment.yaml
    sed -i "s/\$VERSION/${VERSION}/g" course-03/exercises/udacity-c3-deployment/k8s/backend-feed-deployment.yaml

    sed -i "s/\$DEPLOYMENT_NAME/frontend${BETA}/g" course-03/exercises/udacity-c3-deployment/k8s/frontend-deployment.yaml 
    sed -i "s/\$VERSION/${VERSION}/g" course-03/exercises/udacity-c3-deployment/k8s/frontend-deployment.yaml 

    sed -i "s/\$DEPLOYMENT_NAME/reverseproxy${BETA}/g" course-03/exercises/udacity-c3-deployment/k8s/reverseproxy-deployment.yaml
    sed -i "s/\$VERSION/${VERSION}/g" course-03/exercises/udacity-c3-deployment/k8s/reverseproxy-deployment.yaml

    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/backend-feed-deployment.yaml
    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/frontend-deployment.yaml
    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/reverseproxy-deployment.yaml

    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/backend-feed-service.yaml
    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/backend-user-service.yaml
    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/frontend-service.yaml
    kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/reverseproxy-service.yaml
else
    echo "Nothing to release"
fi