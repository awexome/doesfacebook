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
      begin
        if request.referer && request.referer.match(/facebook\.com/) && request.POST["signed_request"]
          env["REQUEST_METHOD"] = "GET"
          Rails.logger.info("  Facebook POST request from #{request.referer} converted to GET request")
        end
      rescue Exception=>e
        Rails.logger.info("  Error in DoesFacebook request conversion: #{e.message}")
        raise e
      end
      @app.call(env)
    end
    
  end  
end # DoesFacebook
