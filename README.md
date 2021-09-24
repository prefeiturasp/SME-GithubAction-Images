# Docker Action (kubernetes one deployment restart)

Esta ação Reinicia um workload específico.

## Inputs

### `deployment`
### `namespace`

**Obrigatório**  deployment e namespace.

## Exemplo de uso
```
uses: luizhpriotto/action_images@kubectl-v1
with:
  deployment: 'workload name'
  namespace: 'namespace name'
```
## Variaveis necessárias
* `RANCHER_URL` - exemplo: rancher.dominio.com.br
* `RANCHER_TOKEN` - exemplo: kubeconfig-u-0000000000:jdmfuritirogs4j2kp98jk4bzbzkfvbnq29v5s8p7scwl7667jtigure
