#!/bin/bash -l

set -e

sed -e "s/\${RANCHER_URL}/${RANCHER_URL}/" -e "s/\${RANCHER_TOKEN}/${RANCHER_TOKEN}/" /runner/config_template > /runner/kube.yaml

cat /runner/kube.yaml

export KUBECONFIG=/runner/kube.yaml

kubectl rollout restart deployment/${WORKLOAD} -n ${NAMESPACE}

rm -f /runner/kube.yaml
