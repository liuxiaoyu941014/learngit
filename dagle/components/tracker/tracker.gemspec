$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tracker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tracker"
  s.version     = Tracker::VERSION
  s.authors     = ["xiaohui"]
  s.email       = ["xiaohui@zhangxh.net"]
  s.homepage    = "http://tanmer.com"
  s.summary     = "Summary of Tracker."
  s.description = "Description of Tracker."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency 'cells', '~> 4.1.4'
  s.add_dependency "cells-rails", '~> 0.0.6'
  s.add_dependency "cells-slim", '~> 0.0.5'
  s.add_dependency 'kaminari'
  s.add_dependency 'kaminari-i18n'
  s.add_dependency 'browser'

  s.add_development_dependency "pg"
end
