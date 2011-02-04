# AWEXOME LABS
# DoFacebook

require 'do_facebook'
require 'rails'
require 'action_controller'

require 'do_facebook/config'
require 'do_facebook/filters'

module DoFacebook

  # Create a Rails Engine
  class Engine < Rails::Engine
    engine_name :dofacebook
  end
  
  # Return the current working version of DoFacebook from VERSION file:
  def self.version
    @@version ||= File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").read
  end
  
end


module ActionController
  class Base
    
    # Call this method within your controller to parse configuration and enabled
    # session validation and parsing
    def self.do_facebook
      self.instance_eval do 
        include DoFacebook::Config
        include DoFacebook::Filters
        prepend_before_filter :parse_signed_request
        prepend_before_filter :validate_signed_request
      
        protected
        attr_reader :fbparams
      end
    end
    
  end
end

