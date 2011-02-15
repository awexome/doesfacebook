# AWEXOME LABS
# DoesFacebook
#
# Filters - before and after filters for controller that process Facebook behavior

module DoesFacebook
  module Filters
    
    protected
    
    # Ensures, using configuration options, that the request was signed by Facebook
    def validate_signed_request
      if request_parameter = request.params["signed_request"]
        if app_secret = facebook_config["secret_key"]
          encoded_signature, encoded_data = request_parameter.split(".")
          decoded_signature = base64_url_decode(encoded_signature)
          digested = OpenSSL::HMAC.digest("sha256", app_secret, encoded_data)
          valid = (digested == decoded_signature)
          if valid
            logger.info "  Facebook Signed Request Valid."
          else
            logger.info "  Facebook Signed Request is not Valid. Ensure request is from Facebook."
            raise "DoesFacebook: Invalid Signed Request. Ensure request is from Facebook."
          end
        end
      end
    end

    
    # If present, parses data from the signed request and inserts it into the fbparams
    # object for use during requests
    def parse_signed_request
      if request_parameter = request.params["signed_request"]
        encoded_signature, encoded_data = request_parameter.split(".")
        decoded_signature = base64_url_decode(encoded_signature)
        decoded_data = base64_url_decode(encoded_data)
        @fbparams = HashWithIndifferentAccess.new(JSON.parse(decoded_data).merge({
          "signature"=>encoded_signature,
          "data"=>encoded_data 
        }))
        logger.info "  Facebook Parameters: #{fbparams.inspect}"
      end
    end
      
      
    
    private
    
    # Base64 URL Decode method
    # see http://developers.facebook.com/docs/authentication/canvas 
    def base64_url_decode(str)
      "#{str}==".tr("-_", "+/").unpack("m")[0]
    end
    
  end
end # DoesFacebook