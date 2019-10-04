class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city

  has_one :contact do
    link(:related) {contact_url(object.contact.id)}
  end

end
