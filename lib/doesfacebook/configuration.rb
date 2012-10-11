# AWEXOME LABS
# DoesFacebook : Configuration

module DoesFacebook

  class Configuration

    # Configurable options:
    attr_accessor :log_level

    # Declare defaults on load:
    def initialize
      @log_level = :silent
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
