# AWEXOME LABS
# DoesFacebook

require 'doesfacebook'
require 'rails'
require 'action_controller'

require 'doesfacebook/config'
require 'doesfacebook/filters'
require 'doesfacebook/controls'
require 'doesfacebook/session'
require 'doesfacebook/middleware'

require 'generators/doesfacebook/config/config_generator'

module DoesFacebook

  # Create a Rails Engine
  class Engine < Rails::Engine
    # engine_name :doesfacebook
  end
  
  # Create a Railtie for Rack, config injection
  class Railtie < Rails::Railtie
    initializer "doesfacebook.init" do |app|
      app.middleware.use DoesFacebook::Middleware
    end
  end
  
  # Return the current working version of DoesFacebook from VERSION file:
  def self.version
    @@version ||= File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").read
  end
  
end # DoesFacebook


module ActionController
  class Base
    
    # Call this method within your controller to parse configuration and enabled
    # session validation and parsing
    def self.does_facebook(opts={})
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


module ActionMailer
  class Base
    
    # Call this method within your controller to parse configuration and enabled
    # session validation and parsing
    def self.does_facebook
      self.instance_eval do 
        include DoesFacebook::Config
        helper :does_facebook
      
        protected
        attr_reader :fbparams
      end
    end
    
  end
end # ActionMailer


