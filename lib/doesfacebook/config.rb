# AWEXOME LABS
# DoesFacebook Config

module DoesFacebook
  module Config
    
    protected
    
    # Load app configuration by Facebook callback path with a fallback to config
    # defined with name matching our current environment:
    def facebook_config
      @facebook_config ||= nil
      return @facebook_config unless @facebook_config.nil?
      app_name, app_config = all_facebook_config.find do |name, config|
        test_callback = request.ssl? ? config["ssl_callback_url"] : config["callback_url"]
        request.url.match(/^#{test_callback}.*/)
      end
      if app_config
        app_config = HashWithIndifferentAccess.new(app_config)
        if app_config[:canvas_name]
          app_config[:namespace] ||= app_config.delete(:canvas_name)
          Rails.logger.warn("  DoesFacebook Deprecation Warning: \"canvas_name\" field in doesfacebook.yml should be renamed \"namespace\" as per Facebook Roadmap")
        end
        Rails.logger.info("  Facebook configuration for app \"#{app_name}\" loaded for request URL #{request.url}")
        @facebook_config = app_config
      else
        Rails.logger.warn("  Facebook configuration could not be found. doesfacebook.yml has no app for host #{request.host}")
        Rails.logger.warn("  Facebook configuration can be generated by running \"rails generate does_facebook:config\"")
      end
      return @facebook_config
    end
    
      
    # Load configuration from YAML file for all environments:
    def all_facebook_config
      return @@all_facebook_config if @all_facebook_config
      config_file = File.join(Rails.root, "config", "doesfacebook.yml")
      if File.exist?(config_file)
        return @@all_facebook_config ||= YAML.load(File.open( config_file ))
      end
    end
        
  end
end # DoesFacebook

