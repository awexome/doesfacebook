# AWEXOME LABS
# DoFacebook Config

module DoFacebook
  module Config
    
    # Access the Facebook-specific configuration for the given environment:
    def self.config
      @@config ||= all_config[Rails.env]
    end
    
    # Load configuration from YAML file for all environments:
    def self.all_config
      @@all_config ||= YAML.load(File.open(File.join(Rails.root, "config", "dofacebook.yml")))
    end
    
    # Given a specific Facebook applicat ID, retrieve the approprite config:
    def self.config_for_app_id(app_id)
      config[app_id]
    end
      
    
    # Given a callback URL, retrieve the appropriate config:
    def self.config_for_callback(url)
      app_config = config.find{|k,v| v.values.include?(url) }
      app_id = app_config && app_config[0]
      config_for_app_id(app_id)
    end
        
  end
end

