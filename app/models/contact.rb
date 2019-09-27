class Contact < ApplicationRecord
    belongs_to :kind

    def kind_description
        self.kind.description
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