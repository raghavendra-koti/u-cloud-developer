#   cloud-developer
content for Udacity's cloud developer nanodegree

## Services
There are four services in this repository/project
* Feed Service - A Node restful service to provide feed of the pictures
* User Service - A Node resutful service to do user management
* Frontend - An ionic based frontend hosted on NGINX
* Reverse Proxy - A NGINX based proxy to route requests from the front end to feed/user service depending on the path

## Build System
* DockerFile is present that builds each of the above projects into a docker image

## Development process (Continuous Integration)
Create a branch out of master and then develop the feature/fix. 
Log a Pull Request to merge into master after development/testing is done
After PR is reviewed and approved, CI/CD process runs a plain vanila build automatically
The plain vanila build verifies code compilation and docker images builds

## Deployment/Release Process (Continuous Deployment)
Deploy and release are separate actions - for the sake of audit 
"Deploy" pushes versioned docker images to Git Hub
"Release" release the appropriate version of the software to the kubernetes cloud in rolling manner to avoid downtime
To deploy/release services, a commit and push to master branch is required. Merge by PR will **NOT** result in Deploy/Release under any circumstance. 

#### The following actions are supported by the automated builds
* DEPLOY - Builds docker images and pushes them to the docker hub with a given version
* RELEASE - Releases the version specified as a rolling release to avoid downtime. Assumes the version has already been deployed in a previous step.
* RELASE-BETA - Releases a new version and runs the services in parallel to the existing version for A/B testing
* PROMOTE - Promotes the BETA version to production
* ROLLBACK - downgrades the version of the services to a specified previous version
* ROLLBACK-BETA - Kills the current beta version instances

#### .travis.yml has the following environment variables that are used to specify the above release modes. Commiting and pushing .travis.yml to master branch directly will automatically trigger deploy/release.
* DEPLOY
ACTION=DEPLOY VERSION=1.0

* RELEASE
ACTION=RELEASE VERSION=1.0

* RELEASE-BETA
ACTION=RELEASE-BETA VERSION=1.1.beta

* PROMOTE
ACTION=PROMOTE VERSION=1.1

* ROLLBACK
ACTION=ROLLBACK ROLLBACK_VERSION=0.9

* ROLLBACK-BETA
ACTION=ROLLBACK_BETA 

