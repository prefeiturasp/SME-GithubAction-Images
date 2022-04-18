# Python 36 com cache do Pipefile


```
pipenv lock --keep-outdated --requirements --dev > requirements.txt
```

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
