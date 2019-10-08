module V1
  class ContactsController < ApplicationController
    include ErrorSerializer
    before_action :set_contact, only: [:show, :update, :destroy]
  
    # GET /contacts
    def index
      page_number = params[:page] ? params[:page][:number].to_s : 1   # Definição do número da página
      page_size = params[:page] ? params[:page][:size].to_s : 5       # Definição do número de itens por página
      # Verifica se existe o parâmetro :page, se sim, utiliza o número indicado para o parâmetro, caso contrário, define 1 por padrão

      @contacts = Contact.all.page(page_number).per(page_size)
      
      render json: @contacts,
      include: [:kind, :address, :phones]
      
      #paginate json: @contacts,                   # Definição para haver paginação
      #include: [:kind, :address, :phones]
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
        render json: ErrorSerializer.serialize(@contact.errors), #@contact.errors, status: :unprocessable_entity
        status: :unprocessable_entity
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
