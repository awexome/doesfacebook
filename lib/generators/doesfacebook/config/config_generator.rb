# AWEXOME LABS
# DoesFacebook Config Generator

require 'rails/generators'
require 'rails/generators/named_base'

module DoesFacebook
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      
      desc "Creates a boilerplate DoesFacebook config/initializer at config/initializers/doesfacebook.rb"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def create_config_file
        template "doesfacebook.rb", File.join("config/initializers","doesfacebook.rb")
      end

    end
  end #Generators
end #DoesFacebook
