# AWEXOME LABS
# DoesFacebook

require "doesfacebook"
require "rails"
require "action_controller"

require "doesfacebook/configuration"
require "doesfacebook/error"
require "doesfacebook/application"
require "doesfacebook/controller_extensions"
require "helpers/does_facebook_helper"

# require "doesfacebook/config"
# require "doesfacebook/filters"
# require "doesfacebook/controls"
# require "doesfacebook/session"

require "doesfacebook/middleware"

# require "generators/doesfacebook/config/config_generator"

module DoesFacebook

  # Add configuration and features to Rails as an Engine:
  class Engine < Rails::Engine
    initializer "doesfacebook.init" do |app|
      app.middleware.use DoesFacebook::Middleware
    end

    paths["app/helpers"] << "lib/helpers"
  end
  
  # Return the current version of the gem:
  def self.version
    @@version ||= File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").read
  end
  
end # DoesFacebook


module ActionController
  class Base
    
    # Call this method within your controller to enable Facebook actions:
    def self.does_facebook(opts={})
      self.instance_eval do
        include DoesFacebook::ControllerExtensions
        helper :does_facebook
      end
    end


    def self.XX_does_facebook(opts={})
      self.instance_eval do 
        include DoesFacebook::Config
        include DoesFacebook::Controls
        include DoesFacebook::Filters
        prepend_before_filter :parse_signed_request, :validate_signed_request
        prepend_before_filter :sessionify_signed_request unless opts[:session]==false
        helper :does_facebook
      
        protected
        attr_reader :fbparams
      end
    end
    
  end
end # ActionController


