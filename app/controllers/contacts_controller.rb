class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all
    render json: @contacts,
    except: :kind_id
  end

  # GET /contacts/1
  def show
    render json: @contact,
    include: [:kind]
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, 
      methods: [:kind_description, :avaiable_phones],
      include: [:address],
      status: :created,
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
      params.require(:contact).permit(
        :name, :email, :birthdate, :kind_id, 
        phones_attributes: [:id, :number, :_destroy], # Deleta um número de telefone associado ao contato
        address_attributes: [:id, :street, :city]
      )
        # Sem a PORRA do *_attributes, não vai funcionar!
        # NUNCA esquecer de definir EXPLICITAMENTE os atributos que serão recebidos em um PUT ou PATCH
    end
end
