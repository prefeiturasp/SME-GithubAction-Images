# Kubectl restart workload

Esta ação reinicia um workload específico ou todos os workloads de um namespace.

## Exemplo de uso
```
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      
      - name: Redeploy
        uses: luizhpriotto/action_images@kubectl-v1.0
        env: 
          RANCHER_URL: ${{ secrets.RANCHER_URL }}
          RANCHER_TOKEN: ${{ secrets.RANCHER_TOKEN }}
          WORKLOAD: workload
          NAMESPACE: namespace
```
## Variaveis necessárias
* `RANCHER_URL` - exemplo: rancher.dominio.com.br
* `RANCHER_TOKEN` - exemplo: kubeconfig-u-0000000000:jdmfuritirogs4j2kp98jk4bzbzkfvbnq29v5s8p7scwl7667jtigure
* `WORKLOAD` - caso especificado reinicia um workload, caso não reinicia todo so workloads do namespace
* `NAMESPACE` - namespace do workloads
