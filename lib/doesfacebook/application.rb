# AWEXOME LABS
# DoesFacebook 
#
# Application -- representation of a single Facebook Application, defined on the
#  developers portal at developers.facebook.com.
#
# Fields used in configuration match Facebook's API keys for the corresponding
# setting whenever possible. For reference, review the Graph API doc for Application:
# https://developers.facebook.com/docs/reference/api/application/
#

module DoesFacebook

  class Application

    attr_accessor :id, :secret, :namespace, :canvas_url, :secure_canvas_url

    # All 
    def initialize(opts={})
      update_options(opts)
      # @id = opts[:id]                                 # <= "App ID" on dashboard
      # @secret = opts[:secret]                         # <= "App Secret" on dashboard
      # @namespace = opts[:namespace]                   # <= "Namespace" on dashboard
      # @canvas_url = opts[:canvas_url]                 # <= "Canvas URL" under "App on Facebook"
      # @secure_canvas_url = opts[:secure_canvas_url]   # <= "Secure Canvas URL" under "App on Facebook"
    end

    # Bulk set configuration options for this application
    def update_options(opts={})
      opts.each do |key, val|
        self.send("#{key}=", val)
      end
    end

    # Error in the case of an unknown key being configured:
    def method_missing(meth, *args, &block)
      if meth.to_s =~ /\=$/
        key_name = meth.to_s.gsub(/\=$/,"")
        raise DoesFacebook::ConfigurationError.new("Unknown configuration key `#{key_name}` cannot be set for Facebook applications.")
      end
      super
    end

    # Return true if this application supports SSL/HTTPS:
    def supports_ssl?
      !secure_canvas_url.nil?
    end

  end # Application
end # DoesFacebook
