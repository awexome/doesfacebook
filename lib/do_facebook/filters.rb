# AWEXOME LABS
# Filters

module DoFacebook
  module Filters
    
    protected
    
    # Ensures, using configuration options, that the request was signed by Facebook
    def validate_signed_request
      logger.debug "VALIDATING SIGNED REQUEST"
      logger.debug "CONFIG IS: #{facebook_config.inspect}"
      if app_secret = facebook_config["secret_key"]
        logger.debug "APP CONFIGRUATION FOUND AND LOADED. SECRET: #{app_secret}"
        if request_parameter = request.params[:signed_request]
          logger.debug "PARSING SIGNED REQUEST"
          encoded_signature, encoded_data = request_parameter.split(".")
          decoded_signature = base64_url_decode(encoded_signature)
          digested = OpenSSL::HMAC.digest("sha256", app_secret, encoded_data)
          valid = (digested == decoded_signature)
          logger.debug "SIGNED REQUEST VALID? #{valid}"
          return valid
        else
          logger.debug "NO SIGNED REQUEST PARAMETER TO PARSE"
        end
      else
        logger.debug "NO CONFIGURATION FOR FACEBOOK APP FOUND"
      end
    end
    
    # If present, parses data from the signed request and inserts it into the fbparams
    # object for use during requests
    def parse_signed_request
      logger.debug "PARSING SIGNED REQUEST"
      request_parameter = request.params[:signed_request]
      encoded_signature, encoded_data = request_parameter.split(".")
      decoded_signature = base64_url_decode(encoded_signature)
      decoded_data = base64_url_decode(encoded_data)
      @fbparams = JSON.parse(decoded_data).merge({
        "signature"=>encoded_signature,
        "data"=>encoded_data 
      })
    end

    
    private
    
    # Base64 URL Decode method
    # see http://developers.facebook.com/docs/authentication/canvas 
    def base64_url_decode(str)
      "#{str}==".tr("-_", "+/").unpack("m")[0]
    end
    
  end
end