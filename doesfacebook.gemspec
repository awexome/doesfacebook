# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{doesfacebook}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["mccolin"]
  s.date = %q{2011-02-12}
  s.description = %q{Paper-thin Facebook validation and signed request parsing Rails plugin}
  s.email = %q{info@awexomelabs.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "app/helpers/does_facebook_helper.rb",
    "config/doesfacebook.yml.example",
    "lib/doesfacebook.rb",
    "lib/doesfacebook/config.rb",
    "lib/doesfacebook/controls.rb",
    "lib/doesfacebook/filters.rb",
    "lib/doesfacebook/session.rb"
  ]
  s.homepage = %q{http://awexomelabs.com/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Paper-thin Facebook validation and signed request parsing Rails plugin}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
  end
end

