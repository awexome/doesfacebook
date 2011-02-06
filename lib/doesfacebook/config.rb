# AWEXOME LABS
# DoesFacebook Config

module DoesFacebook
  module Config
    
    protected
    
    # Access the Facebook-specific configuration for the given environment:
    def facebook_config
      @@facebook_config ||= all_facebook_config[Rails.env]
    end
    
    # Load configuration from YAML file for all environments:
    def all_facebook_config
      config_file = File.join(Rails.root, "config", "dofacebook.yml")
      if File.exist?(config_file)
        return @@all_facebook_config ||= YAML.load(File.open( config_file ))
      end
    end
        
  end
end # DoesFacebook

