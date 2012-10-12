# AWEXOME LABS
# DoesFacebook : Configuration

module DoesFacebook

  class Configuration

    # Configurable options:
    attr_accessor :applications, :app_selector

    # Declare defaults on load:
    def initialize
      @applications = Array.new
      @app_selector = Proc.new() do |request, apps|
        apps.find do |a|
          callback_path = request.ssl? && a.supports_ssl? ? a.secure_canvas_url : a.canvas_url
          request.url.match(/^#{callback_path}.*/)
        end
      end
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
      app = DoesFacebook::Application.new(app) if app.is_a?(Hash)
      @applications << app
    end

    # Determine the current app given an incoming request:
    def current_application(request)
      app_selector.call(request, applications)
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
