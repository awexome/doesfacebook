# AWEXOME LABS
# Filters

module DoFacebook
  module Filters
    
    protected
    
    # Ensures, using configuration options, that the request was signed by Facebook
    def validate_signed_request
    end
    
    # If present, parses data from the signed request and inserts it into the fbparams
    # object for use during requests
    def parse_signed_request
    end
    
  end
end