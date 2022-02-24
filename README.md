# Dotnet Sonar Scanner

Esta ação analisa o códido através do SonarQube e valida o Quality Gate para Dotnet

## Exemplo de uso
```
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      
      - name: Sonar
        uses: luizhpriotto/action_images@sonarscanner-v1.0
        env:
          DOTNET_PROJECT: SME.SERAp.Prova.Api.sln
          SONAR_PROJECT_KEY: ${{ secrets.SONAR_PROJECT_KEY }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
          SONAR_HOST: http://sonar.domain.local/
          SONAR_EXTRA_ARG: >
            /d:sonar.cs.opencover.reportsPaths='"teste/SME.SERAp.Aplicacao.Test/coverage.opencover.xml","teste/SME.SERAp.Dominio.Test/coverage.opencover.xml"'
            /d:sonar.coverage.exclusions='"**Test*.cs"'
```
## Variaveis necessárias
* `SONAR_PROJECT_KEY` -  chave do projeto
* `SONAR_TOKEN` - token de acesso
* `SONAR_HOST` - endereço do SonarQube
* `DOTNET_PROJECT` - nome projet sln
