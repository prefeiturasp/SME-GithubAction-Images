#!/bin/bash -l

set -e

#$1 = deployment name / ${INPUT_DEPLOYMENT}
#$2 = namespace / ${INPUT_NAMESPACE}


echo ${RANCHER_URL}

sed -e "s/\${RANCHER_URL}/${RANCHER_URL}/" -e "s/\${RANCHER_TOKEN}/${RANCHER_TOKEN}/" /runner/config_template > /runner/kube.yaml

cat /runner/kube.yaml

export KUBECONFIG=/runner/kube.yaml
env
echo ${INPUT_DEPLOYMENT}
echo ${INPUT_NAMESPACE}
echo $HOME
echo ${HOME}
echo $KUBECONFIG
echo ${KUBECONFIG}

kubectl rollout restart deployment/$1 -n $2

#res=$(kubectl rollout restart deployment/$1 -n $2)

#echo "::set-output name=res::$res"

rm -f /runner/kube.yaml
