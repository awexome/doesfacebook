# AWEXOME LABS
# DoesFacebook 
#
# Error -- represent individual configuration and runtime errors specific to
#  the Facebook application or DoesFacebook
#

module DoesFacebook
  
  class Error < StandardError
    def initialize(message="DoesFacebook Runtime Error")
      super
    end
  end # Error

  
  class ConfigurationError < Error
    def initialize(message="DoesFacebook Configuration Error")
      super
    end
  end # ConfigurationError


  class MiddlewareError < Error
    def initialize(message="DoesFacebook Runtime Error")
      super
    end
  end # MiddlewareError


end # DoesFacebook
