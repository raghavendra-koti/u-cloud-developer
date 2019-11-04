 #!/usr/bin/bash

 kubectl delete deployment "backend-feed-beta" --grace-period=60
 kubectl delete deployment "backend-user-beta" --grace-period=60
 kubectl delete deployment "frontend-beta" --grace-period=60
 kubectl delete deployment "reverseproxy-beta" --grace-period=60