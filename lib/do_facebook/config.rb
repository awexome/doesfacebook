# AWEXOME LABS
# DoFacebook Config

module DoFacebook
  module Config
    
    protected
    
    # Access the Facebook-specific configuration for the given environment:
    def facebook_config
      logger.debug "ACCESSING CONFIG"
      @@facebook_config ||= all_facebook_config[Rails.env]
    end
    
    # Load configuration from YAML file for all environments:
    def all_facebook_config
      logger.debug "ACCESSING ALL_CONFIG. LOAD FROM YAML IF FIRST TIME"
      config_file = File.join(Rails.root, "config", "dofacebook.yml")
      if File.exist?(config_file)
        logger.debug "CONFIGURATION FILE dofacebook.yml READY TO LOAD"
        return @@all_facebook_config ||= YAML.load(File.open( config_file ))
      else
        logger.debug "CONFIGURATION FILE dofacebook.yml DOES NOT EXIST"
      end
    end
        
  end
end

