#!/bin/bash -l

sed -e "s/\${RANCHER_URL}/$RANCHER_URL/" -e "s/\${RANCHER_TOKEN}/$RANCHER_TOKEN/" /runner/config_template > /runner/.kube/config

kubectl rollout restart deployment/$1 -n $2

rm -f /runner/.kube/config
