# Python3.6 com cache do Pip



## Exemplo de uso
```
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      
      - name: Running Python Tests
        uses: luizhpriotto/action_images@terceirizadas-backend-cache-v1.0
        with:
          command: |
            pipenv run pytest
            pipenv run flake8
```
