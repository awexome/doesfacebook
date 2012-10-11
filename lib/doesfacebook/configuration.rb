# AWEXOME LABS
# DoesFacebook : Configuration

module DoesFacebook

  class Configuration

    # Configurable options:
    attr_accessor :applications

    # Declare defaults on load:
    def initialize
      @applications = Array.new
    end

    # If an unknown settings is configured, notify the user:
    def method_missing(meth, *args, &block)
      if meth.to_s =~ /\=$/
        key_name = meth.to_s.gsub(/\=$/,"")
        raise DoesFacebook::ConfigurationError.new("Unknown configuration `#{key_name}` cannot be set for DoesFacebook.")
      end
      super
    end

    # Add an application definition:
    def add_application(app)
      @applications << app
    end

  end # Configuration


  # Provide an accessor to the gem configuration:
  class << self
    attr_accessor :configuration
  end

  # Yield the configuration to host:
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  DoesFacebook.configuration = Configuration.new

end # DoesFacebook
