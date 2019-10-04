class ApplicationController < ActionController::API

    include ActionController::HttpAuthentication::Token::ControllerMethods
    TOKEN = "secret123"

    # Agora é requisitado para absolutamente qualquer chamada uma autenticação do tipo básica
        # include ActionController::HttpAuthentication::Basic::ControllerMethods
        # http_basic_authenticate_with name: "abc", password: "123"

   before_action :authenticate 
   before_action :ensure_json_request

    def ensure_json_request
        if request.headers["Accept"] =~ /json/
            self            
        else
            render nothing: true, status: 406         
        end
    end

    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            ActiveSupport::SecurityUtils.secure_compare(
                ::Digest::SHA256.hexdigest(token),
                ::Digest::SHA256.hexdigest(TOKEN)
            )
        end
    end

end
