require 'rack'

app = Proc.new do |env|
    # Intercepta uma resposta/chamada
    #> ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]


    # Faço qualquer coisa, desde que não altere a estrutura da resposta/chamada 


    # Devolvo, até mesmo alterado a estrutura da resposta/chamada
    ['200', {'Content-Type' => 'text/html'}, ["#{env}"]]
end

# EXAMPLE FOR RUN THIS SPECIFIC RACK
#  Rack::Handler::WEBrick.run app, :Port => 3000