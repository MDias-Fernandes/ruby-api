class ApplicationController < ActionController::API

    # Usando autenticação com TOKEN
        # include ActionController::HttpAuthentication::Token::ControllerMethods
        # TOKEN = "secret123"
        # before_action :authenticate
        # def authenticate
        #     authenticate_or_request_with_http_token do |token, options|
        #         ActiveSupport::SecurityUtils.secure_compare(
        #             ::Digest::SHA256.hexdigest(token),
        #             ::Digest::SHA256.hexdigest(TOKEN)
        #         )
        #     end
        # end        

    # Agora é requisitado para absolutamente qualquer chamada uma autenticação do tipo básica
        # include ActionController::HttpAuthentication::Basic::ControllerMethods
        # http_basic_authenticate_with name: "abc", password: "123"
 
    include ActionController::HttpAuthentication::Token::ControllerMethods
    # before_action :ensure_json_request
    before_action :authenticate

    def ensure_json_request
        if request.headers["Accept"] =~ /json/
            self            
        else
            render nothing: true, status: 406
        end
        
        unless request.get? # FAÇA A NÃO SER QUE SEJA FALSE!!!!!!
            return if request.headers["Content-Type"] =~ /json/
            render nothing: true, status: 415
        end

    end

    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            hmac_secret = 'my$3cr3tK3y'
            JWT.decode token, hmac_secret, true, {:algorithm => 'HS256'}
        end
    end

end
