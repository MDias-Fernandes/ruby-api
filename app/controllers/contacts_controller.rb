class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all
    render json: @contacts,  #{ |contact| contact.attributes.merge({author: "Matheus Dias"})} --- Mergeia novos atributos ao payload da response
      status: :partial_content, #> Definir manulmente qual status_code quero que seja respondido às chamadas
      root: true, #> Com esse boolean, pode-se definir se a raíz (origem) do dado será exibida ou não
      only: [:name, :email], #> Definição de quais dados serão exibidos na resposta à chamada
      except: [:birthdate], #> Definição de quais dados NÃO serão exibidos na resposta à chamada

      methods: :author #> Utilização de um método personalizado que está contruído no arquivo ../ruby-api-project/app/models/contact.rb
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
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
      params.require(:contact).permit(:name, :email, :birthdate)
    end
end
