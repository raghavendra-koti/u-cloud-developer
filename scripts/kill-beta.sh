 #!/usr/bin/bash
 kubectl delete deployment "backend-feed-BETA" --grace-period=60
 kubectl delete deployment "backend-user-BETA" --grace-period=60
 kubectl delete deployment "frontend-BETA" --grace-period=60
 kubectl delete deployment "reverseproxy-BETA" --grace-period=60