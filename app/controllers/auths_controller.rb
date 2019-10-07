class AuthsController < ApplicationController

    def create
        hmac_secret = 'my$3cr3tK3y'
        payload = {name: params[:name], exp: Time.now.to_i + 18000} # Os tokens expiram a cada 30 segundos
        token = JWT.encode payload, hmac_secret, 'HS256'
        render json: {token: token}
    end

end
