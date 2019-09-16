# README

- Create a rails project only for APIs:
    > rails new ruby-api-project --api

- Up the server with rails app:
    > rails s

- Create a scaffold:
    > rails g scaffold contact name:string email:string birthdate:string value:type

- Run:
    > rails db:migrate

- Generate a rake:
    > rails generate task dev setup

- Run rake:
    > rails dev:setup

- Recursos:
    > config/routes - descreve os recursos existentes na minha aplicação
    > o recurso(rota) contacts foi criado, ou seja, URLs disponíveis para solicitar ao servidor algum serviço.
    > os recursos são sempre escritos no PLURAL.
    > recursos são sempre SUBSTANTIVOS e nunca VERBOS