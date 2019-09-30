# README

- Create a rails project only for APIs:
    - `rails new ruby-api-project --api`

- Up the server with rails app:
    - `rails s`

- Create a scaffold:
    - `rails g scaffold contact name:string email:string birthdate:string value:type`

- Run:
    - `rails db:migrate` - Alteração da estrutura do BD e maném um log de alterações realizadas

- Generate a rake:
    - `rails generate task dev setup`

- Run rake:
    - `rails dev:setup` - Executar uma operação que não necessariamente está associada às regras de negócio

- Recursos:
    - config/routes - descreve os recursos existentes na minha aplicação
    - o recurso(rota) contacts foi criado, ou seja, URLs disponíveis para solicitar ao servidor algum serviço.
    - os recursos são sempre escritos no PLURAL.
    - recursos são sempre SUBSTANTIVOS e nunca VERBOS

- curl:
    - Com o '-v' na chamada com curl, é possível identificar toda a estrutura da chamada e não apenas a resposta
    - Com o '-X' na chamada com curl, é possível definir qual verbo HTTP será utilizado na chamada (GET, PUT, POST, PATCH)
    - Com o '-i' na chamada com curl, é possível identificar todo o cabeçalho da resposta à chamada HTTP
    - Com o '-H' na chamada com curl, é possível indicar que uma parâmetro no Header será enviado, por exemplo, `-H Content-Type: application/json`
    - Com o '-d' na chamada com curl, é possível enviar um body para a chamada (POST, PUT e PATCH), por exemplo, `-d '{"name": "value", "data": 500}'`
        
- Cabeçalho de uma resposta HTTP:
    - Start-line: Versão HTTP usada + Status da chamada
    - Header-Fields: Representação dos metadados, ex. Content-type: application/json
    - Empty-line: Separa o cabeçalho da resposta propriamente dita
    - Message-Body: Corpo da resposta à chamada HTTP (resposta do servidor)

- REST e RESTful
    - Formalização de um conjunto de melhores práticas denominadas CONSTRAINTS
    - CONSTRAINTS:
        - Client/Server, ou seja, separação das responsabilidades entre Client e Server
        - Stateless, cada requisição é única e deve ser suficientemente completa em infos necessárias para ser tratada com sucesso pelo servidor
        - Cache, respostas passíveis de cache
        - Interface Uniforme, deve haver padronização, por exemplo, Recursos ou até mesmo as mensagens que devem ser auto-explicativas
        - Sistemas em camadas, uso de um load balancer, por exemplo, pois isso permite a escalabilidade da aplicação sem impactá-la
    - REST é um conjunto de boas práticas denominadas CONSTRAINTS
    - Uma API que não segue os princípios REST é apenas uma API HTTP
    - Uma API que segue os princípios REST, temos uma API RESTful

- HTTP status code
    - 1xx - informacional
    - 2xx - sucesso entre client e server
    - 3xx - redirecional (passo adicional)
    - 4xx - erro do lado do CLIENT
    - 5xx - erro do lado do SERVER
    - No rails >>> status: `:rails_code`

- Map/Collect
    - map >>> constrói um novo objeto, um novo array, por exemplo
    - each >>> não cria um novo objeto, fica restrito à execução da sentença

- Render JSON
    - Active Support JSON
        - Possui `ActiveSupport::JSON.encode(hash)` para transformar um hash em um json, e `ActiveSupport::JSON.decode(json)` para reverter um json para hash
        - Elemento raíz, `root: true`, vem com o nome da origem dos dados
        - Com o `only` e o `except` é possível manipular o que será exibido usando o `render json:`
        - Com o `as_json` sobrescrevo o método original e passo via parâmetros quais personalizações quero para as responses de todas as APIs de um determinado recurso

- Novo CRUD com tabelas relacionadas
    - `rails g scaffold Kind description:string` - Criação de um CRUD padrão, nome da tabela é `Kind`
    - `rails g migration add_kind_to_contact kind:references` - Cria uma chave estrangeira 'referência' dentro da tabela contacts
    - `rails db:migrate`
    - `rails db:drop db:create db:migrate dev:setup`
    - `belongs_to`, `has_one`, `has_many`, `has_and_belongs_to_many`

- Trazer outros dados de uma entidade relacionada - inclusão da lógica em `models/contact.rb`
    - Exibição aninhada: `include: {kind: {only: :description}}`
    - Exibição na estrutura inicial:
        - Criação de um método:
            `def kind_description`
                `self.kind.description`
            `end`
        - Chamada desse método sobrescrevendo o método `as_json`:
            `methods: [:kind_description]`
        - Para a não exibição de dados:
            `except: :kind_id`

- PERSONALIZAÇÃO da exibição de atributos quando um determinado recurso é consumido:
    - Sobrescrita de método `as_json` para todos os recursos
        - No model eu posso sobrescrever o método originalmente implementado para que a exibição personalizada seja padrão para todos os recursos
    - Personalizar a exibição especificamente em um recurso
        - Definir na estrutura do `Controller`

- Registro de dados na API
    - No método `contact_params` é necessário que os atributos que serão registrados na base sejam explicitamente identificados
    - Ou não utilizar o parâmetro `optional`, como por exemplo `belongs_to :kind, optional: true`

- Usar I18n para internacionalização de dados, como por exemplo datas.
    - `I18n.l(Date.today)` => 01/01/2000

- Criação de mais relacionamentos
    - `rails g model Phone number:string contact:references` - Modelo que possui uma referência para a entidade contact
    - `rails db:migrate`
    - `rails db:drop db:create db:migrate dev:setup`
    - `rails dev:set_phones`

- Quando um `Model` é criado, nesse caso `Phones`, só é possível atualizá-lo na criação ou atualização de um contato