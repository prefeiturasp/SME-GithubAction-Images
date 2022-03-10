#!/bin/bash -l

set -e

sed -e "s/\${RANCHER_URL}/${RANCHER_URL}/" -e "s/\${RANCHER_TOKEN}/${RANCHER_TOKEN}/" /runner/config_template > /runner/kube.yaml

cat /runner/kube.yaml

export KUBECONFIG=/runner/kube.yaml

if [ -z "$WORKLOAD" ]; then
    kubectl -n ${NAMESPACE} rollout restart deploy
    exit 0
fi


IN=${WORKLOAD}

workloads=$(echo $IN | tr "," "\n")

for work in $workloads
do
    kubectl rollout restart deployment/$work -n ${NAMESPACE}
done

rm -f /runner/kube.yaml
exit 0
