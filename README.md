#   cloud-developer
content for Udacity's cloud developer nanodegree

Development process

Create a branch out of master and then develop the feature/fix. 
Log a Pull Request to merge into master after development/testing is done
After PR is reviewed and approved, CI/CD process runs a plain vanila build automatically
The plain vanila build verifies code compilation and docker images builds

CI/CD Process
If a merge happens by a PR, code is compiled and docker image building is checked
To deploy/release following is the process
Deploy and release are separate actions - for the sake of audit 
"Deploy" pushes versioned docker images to Git Hub
"Release" release the appropriate version of the software to the kubernetes cloud in rolling manner to avoid downtime

There are various release modes
1. RELEASE - Releases the version specified as a rolling release to avoid downtime
2. RELASE-BETA - Releases a new version and runs the services in parallel to the existing version for A/B testing
3. PROMOTE - Promotes the BETA version to production
4. ROLLBACK - downgrades the version of the services to a specified previous version
5. ROLLBACK-BETA - Kills the beta version instances

.travis.yml has the following environment variables that are used to specify the above release modes

1. BUILD
ACTION=BUILD

2.  

