#!/bin/bash -l

set -e

#$1 = deployment name / ${INPUT_DEPLOYMENT}
#$2 = namespace / ${INPUT_NAMESPACE}


echo ${RANCHER_URL}

sed -e "s/\${RANCHER_URL}/${RANCHER_URL}/" -e "s/\${RANCHER_TOKEN}/${RANCHER_TOKEN}/" /runner/config_template > /runner/.kube/config

cat /runner/.kube/config
env
echo ${INPUT_DEPLOYMENT}
echo ${INPUT_NAMESPACE}
echo $HOME
echo ${HOME)
kubectl rollout restart deployment/$1 -n $2

#res=$(kubectl rollout restart deployment/$1 -n $2)

#echo "::set-output name=res::$res"

rm -f /runner/.kube/config
