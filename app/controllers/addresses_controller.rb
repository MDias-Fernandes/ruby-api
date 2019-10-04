class AddressesController < ApplicationController
    before_action :set_address

  # GET /phones/1
  def show
    render json: @address
    require 'pry'; binding.pry
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    require 'pry'; binding.pry
    def set_address
        @address = Contact.find(params[:contact_id]).address
    end

end