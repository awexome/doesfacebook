# AWEXOME LABS
# DoFacebook

require 'do_facebook/config'
require 'do_facebook/session'
require 'do_facebook/filters'


module DoFacebook
  
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
      include DoFacebook::Filters
      prepend_before_filter :validate_signed_request
      prepend_before_filter :parse_signed_request
    end
    
    
    def self.plays_faceball
      self.instance_eval do
        include Faceball::ControllerExtensions::BeforeFilters
        include Faceball::ControllerExtensions::Facebook
        prepend_before_filter :populate_user
        prepend_before_filter :load_current_user
        prepend_before_filter :init_state
        helper :faceball
        protected
        attr_reader :fb_state, :current_user, :fb_cookies
        @@permission_list = nil
      end
    end
    
    # options are before_filter options (:except, :only etc.)
    def self.requires_permissions(perm_list = [], options = {})
      raise "requires_permissions must be called after plays_faceball" if !defined?(@@permission_list)
      self.instance_eval do
        @@permission_list = perm_list.is_a?(Array) ? perm_list.join(',') : perm_list.to_s
        before_filter :require_permissions, options
      end
    end
    
  end
end

