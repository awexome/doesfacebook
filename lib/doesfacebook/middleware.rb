# AWEXOME LABS
# DoesFacebook
#
# Middleware - Rack adapter for POST conversion, etc.

module DoesFacebook
  class Middleware
    
    def initialize(app)
      @app = app
    end
    
    def call(env)
      request = Rack::Request.new(env)
      if !request.xhr? && request.POST["signed_request"]
        env["REQUEST_METHOD"] = "GET"
        Rails.logger.info("  Facebook POST request converted to GET request")
      end
      @app.call(env)
    end
    
  end  
end # DoesFacebook
