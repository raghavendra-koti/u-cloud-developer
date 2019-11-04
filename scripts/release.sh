 #!/usr/bin/bash
ACTION=$1
VERSION=$2
BETA=""

if [$TRAVIS_PULL_REQUEST != "false"]
    exit 0
fi

if[$ACTION == "RELEASE" -o $ACTION == "RELEASE-BETA" -o $ACTION == "PROMOTE" -o $ACTION == "ROLLBACK" -o $ACTION == "ROLLBACK-BETA"]
then
    if[$ACTION == "ROLLBACK"]
    then
        VERSION = $3
    fi

    if [$ACTION == "RELEASE-BETA"]
    then
        BETA = "-BETA"

        sed -i "s/replicas.*/1/g" course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
        sed -i "s/replicas.*/1/g" course-03/exercises/udacity-c3-deployment/k8s/backend-feed-deployment.yaml
        sed -i "s/replicas.*/1/g" course-03/exercises/udacity-c3-deployment/k8s/frontend-deployment.yaml
        sed -i "s/replicas.*/1/g" course-03/exercises/udacity-c3-deployment/k8s/reverseproxy-deployment.yaml
    fi 

    if [$ACTION == "ROLLBACK-BETA"]
    then
        ./scripts/kill-beta.sh
        exit 0
    fi

    if [$ACTION == "PROMOTE"]
    then
        ./scripts/kill-beta.sh
    fi

    ./prepare-release.sh

    sed -i "s/\$DEPLOYMENT_VERSION/backend-user${BETA}/g" course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml
    sed -i "s/\$VERSION/${VERSION}/g" course-03/exercises/udacity-c3-deployment/k8s/backend-user-deployment.yaml

    sed -i "s/\$DEPLOYMENT_VERSION/backend-feed${BETA}/g" ../course-03/exercises/udacity-c3-deployment/k8s/backend-feed-deployment.yaml
    sed -i "s/\$VERSION/${VERSION}/g" course-03/exercises/udacity-c3-deployment/k8s/backend-feed-deployment.yaml

    sed -i "s/\$DEPLOYMENT_VERSION/frontend${BETA}/g" ../course-03/exercises/udacity-c3-deployment/k8s/frontend-deployment.yaml 
    sed -i "s/\$VERSION/${VERSION}/g" course-03/exercises/udacity-c3-deployment/k8s/frontend-deployment.yaml 

    sed -i "s/\$DEPLOYMENT_VERSION/reverseproxy${BETA}/g" ../course-03/exercises/udacity-c3-deployment/k8s/reverseproxy-deployment.yaml
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