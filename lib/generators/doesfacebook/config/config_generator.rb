# AWEXOME LABS
# DoesFacebook Config Generator

require 'rails/generators'
require 'rails/generators/named_base'

module DoesFacebook
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      
      desc "Creates a boilerplate DoesFacebook configuration file at config/doesfacebook.yml"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def create_config_file
        template "doesfacebook.yml", File.join("config","doesfacebook.yml")
      end

    end
  end #Generators
end #DoesFacebook