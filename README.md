# Python3.6


## Exemplo de uso
```
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      
      - name: Running Python Tests
        uses: luizhpriotto/action_images@python36-v1.0
        with:
          command: |
            pip install --user pipenv
            pipenv install --dev
            pipenv run pytest
            pipenv run flake8
```
