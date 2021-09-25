#!/bin/bash -l

#$1 = deployment name
#$2 = namespace

ls
pwd

cat /runner/config_template

echo $RANCHER_URL

sed -e "s/\${RANCHER_URL}/$RANCHER_URL/" -e "s/\${RANCHER_TOKEN}/$RANCHER_TOKEN/" /runner/config_template > /runner/.kube/config

cat /runner/.kube/config

echo $1
echo $2

kubectl rollout restart deployment/$1 -n $2

#res=$(kubectl rollout restart deployment/$1 -n $2)

#echo "::set-output name=res::$res"

rm -f /runner/.kube/config
