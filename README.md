# Informações sobre o projeto

Este projeto é sobre um teste de importação de arquivos basicamente. Está hospedado no heroku com endereço https://import-files-rtoledo.herokuapp.com/

Ele está utilizando rails 6.*, Redis, sidekiq, PostgresSQL e rspec para tests

## Para iniciar o projeto

Depois de baixar o projeto do repositório execute na raiz do projeto

`bundle`

`rails db:create db:migrate`

`redis-server`

`yarn`

## Executando os tests

O projeto está com 95% de cobertura de testes utilizando testes unitários e systema|featuress. Para rodar os testes execute na linha de comando

`bundle exe guard`

E aperte **Enter**. Assim ele irá rodar todos os testes e apontar erros e a quantidade de cobertura.
