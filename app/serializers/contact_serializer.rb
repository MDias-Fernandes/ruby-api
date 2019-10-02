class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  # Lidando com associações
  belongs_to :kind 
  has_many :phones
  has_one :address


  #Inclusão de metadados
  meta do
    {
      author: "Nome do autor"
    }
  end

  #I18n padrão ISO
  # def attributes(*args)
  #   h = super(*args)
  #   h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
  # end
end
