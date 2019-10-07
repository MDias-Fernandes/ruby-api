module V1
  class ContactsController < ApplicationController
    before_action :set_contact, only: [:show, :update, :destroy]
  
    # GET /contacts
    def index
      @contacts = Contact.all.page(params[:page]) # Uso de queryStrings
      paginate json: @contacts,                   # Definição para haver paginação
      include: [:kind, :address, :phones]
    end
  
    # GET /contacts/1
    def show
      render json: @contact,
      include: [:kind, :address, :phones]
    end
  
    # POST /contacts
    def create
      @contact = Contact.new(contact_params)
  
      if @contact.save
        render json: @contact,
        include: [:kind, :address, :phones],
        location: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, 
        include: [:phones, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /contacts/1
    def destroy
      @contact.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def contact_params
          # params.require(:contact).permit(
          #   :name, :email, :birthdate, :kind_id, 
          #   phones_attributes: [:id, :number, :_destroy], # Deleta um número de telefone associado ao contato
          #   address_attributes: [:id, :street, :city]
          # )
          #
          #
          # Sem a PORRA do *_attributes, não vai funcionar!
          # NUNCA esquecer de definir EXPLICITAMENTE os atributos que serão recebidos em um PUT ou PATCH
          
          # Usando a desserialização para json:api
          ActiveModelSerializers::Deserialization.jsonapi_parse(params) # pode ser usado `only`, `except` e `keys`
      end
  end
end
