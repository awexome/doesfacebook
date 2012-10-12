# AWEXOME LABS
# DoesFacebook
#
# ControllerExtensions - convenience methods and filters injected into controllers
#  which enact DoesFacebook
#

module DoesFacebook
  module ControllerExtensions
    
    protected

    def fb_app
      DoesFacebook.configuration.current_application(request)
    end

    def url_for_canvas(opts={})
      canvas_root = if request.ssl? && fb_app.supports_ssl?
        "https://apps.facebook.com/#{fb_app.namespace}/"
      else
        "http://apps.facebook.com/#{fb_app.namespace}/"
      end
      case opts
        when String
          opts =~ /:\/\// ? opts : File.join(canvas_root, opts)
        when Hash
          opts.merge(:only_path=>true)
          File.join(canvas_root, url_for(opts))
      end
    end

    def redirect_to_canvas(opts={})
      @facebook_redirect_url = url_for_canvas(opts)
      Rails.logger.info "Canvas Redirect to #{@facebook_redirect_url}"
      begin
        render :partial=>"facebook/redirect"
      rescue ActionView::MissingTemplate => e
        logger.info "Pretty Redirect Partial facebook/redirect Not Found. Using Unformatted Text."
        render :text=>%{
          Redirecting you to <a href="#{@facebook_redirect_url}">#{@facebook_redirect_url}</a>...
          <script type="text/javascript"> top.location.href = "#{@facebook_redirect_url}"; </script>
        }.html_safe
      end
    end



    private

    # Captures a signed_request parameter and manipulates the session to allow for
    # a signed_request to be passed from iframe request to iframe request
    # def sessionify_signed_request
    #   if request_parameter = request.params["signed_request"]
    #     session[:signed_request] = request_parameter
    #     logger.info "  Facebook Signed Request received. Stored/updated in session."
    #   else
    #     params["signed_request"] = session[:signed_request]
    #     logger.info "  No Facebook Signed Request received. Loaded, if present, from session."
    #   end
    # end
    
    # Ensures, using configuration options, that the request was signed by Facebook
    def validate_signed_request
      if request_parameter = request.params["signed_request"]
        encoded_signature, encoded_data = request_parameter.split(".")
        decoded_signature = base64_url_decode(encoded_signature)
        digested = OpenSSL::HMAC.digest("sha256", fb_app.secret, encoded_data)
        if valid = (digested == decoded_signature)
          Rails.logger.info "  Facebook Signed Request Valid."
        else
          Rails.logger.info "  Facebook Signed Request is not Valid. Ensure request is from Facebook."
          raise DoesFacebook::RequestSignatureInvalidError.new()
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
        @fbparams = HashWithIndifferentAccess.new(JSON.parse(decoded_data))
        Rails.logger.info "  Facebook Parameters: #{fbparams.inspect}"
      end
    end
    
    
    # Base64 URL Decode method
    # see http://developers.facebook.com/docs/authentication/canvas 
    def base64_url_decode(str)
      "#{str}==".tr("-_", "+/").unpack("m")[0]
    end
    
  end # ControllerExtensions
end # DoesFacebook
