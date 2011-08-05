# AWEXOME LABS
# DoesFacebook

require 'doesfacebook'
require 'rails'
require 'action_controller'

require 'doesfacebook/config'
require 'doesfacebook/filters'
require 'doesfacebook/controls'
require 'doesfacebook/session'

module DoesFacebook

  # Create a Rails Engine
  class Engine < Rails::Engine
    # engine_name :doesfacebook
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
    def self.does_facebook
      self.instance_eval do 
        include DoesFacebook::Config
        include DoesFacebook::Controls
        include DoesFacebook::Filters
        prepend_before_filter :parse_signed_request
        prepend_before_filter :validate_signed_request
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


