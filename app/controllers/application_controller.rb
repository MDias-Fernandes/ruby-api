class ApplicationController < ActionController::API
    before_action :ensure_json_request

    def ensure_json_request
        if request.headers["Accept"] =~ /json/
            self            
        else
            render nothing: true, status: 406         
        end
    end
end
