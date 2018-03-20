$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "like/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "like"
  s.version     = Like::VERSION
  s.authors     = ["linan"]
  s.email       = ["linan.avvo@gmail.com"]
  s.homepage    = "http://tanmer.com"
  s.summary     = "Summary of Like."
  s.description = "Description of Like."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
end
