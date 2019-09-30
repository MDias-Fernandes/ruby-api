class Contact < ApplicationRecord

    # Definição das ASSOCIAÇÕES de todos os relacionamentos que essa entidade possui com as demais
    # Uma vez definido que o atributo pode ser OPCIONAL, ele deve permanecer opicional, se não a aplicação vai quebrar

    belongs_to :kind 
    has_many :phones
    
    accepts_nested_attributes_for :phones, allow_destroy: true 
    #Permite incluir o atributo associado através da chamada e DELETAR também os telefones através de um PATCH no contato

    def kind_description
        self.kind.description
    end

    def avaiable_phones
        self.phones.map do |phone|
            phone.number
        end
    end

    # def random
    #     Faker::Name.name
    # end

    # def as_json(options={})
    #     super(
    #         root: true,
    #         methods: [:random, :kind_description], #{ |contact| contact.attributes.merge({author: "Matheus Dias"})} --- Mergeia novos atributos ao payload da response
    #         except: :kind_id
    #     )
    # end

end

    # status: :partial_content,       #> Definir manulmente qual status_code quero que seja respondido às chamadas
    # root: true,                     #> Com esse boolean, pode-se definir se a raíz (origem) do dado será exibida ou não
    # only: [:name, :email],          #> Definição de quais dados serão exibidos na resposta à chamada
    # except: [:birthdate],           #> Definição de quais dados NÃO serão exibidos na resposta à chamada
    # methods: :author                #> Utilização de um método personalizado que está contruído no arquivo ../ruby-api-project/app/models/contact.rb
    # include: :table                 #> Inclui os dados de uma entidade que esteja associada