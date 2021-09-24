#!/bin/bash -l

#$1 = deployment name
#$2 = namespace

sed -e "s/\${RANCHER_URL}/$RANCHER_URL/" -e "s/\${RANCHER_TOKEN}/$RANCHER_TOKEN/" /runner/config_template > /runner/.kube/config

kubectl rollout restart deployment/$1 -n $2

#res=$(kubectl rollout restart deployment/$1 -n $2)

#echo "::set-output name=res::$res"

rm -f /runner/.kube/config
