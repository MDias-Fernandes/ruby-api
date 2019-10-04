class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  # Lidando com associações, esses links serão renderizados na resposta à chamada da API
  belongs_to :kind do
    link(:related) {contact_kind_url(object.id)}
  end
  
  has_many :phones do
    link(:related) {contact_phones_url(object.id)}
  end

  has_one :address do
    link(:related) {contact_address_url(object.id)}
  end


  #criação de links apenas com o path -> contact_path
    # link(:self) {contact_path(object.id)}
    # link(:qualquer_nome) {contact_path(object.name)}
    # link(:nomeNomeNome) {contact_path(object.birthdate)}
    # link(:youTube) {"http://www.youtube.com"}

  #com url completa -> contact_url
    # link(:self) {contact_url(object.id)}

  #Inclusão de metadados
    # meta do
    #   {
    #     author: "Nome do autor"
    #   }
    # end

  #I18n padrão ISO
  # def attributes(*args)
  #   h = super(*args)
  #   h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
  # end
end
