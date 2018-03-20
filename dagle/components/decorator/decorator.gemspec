$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "decorator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "decorator"
  s.version     = Decorator::VERSION
  s.authors     = ["xiaohui"]
  s.email       = ["xiaohui@zhangxh.net"]
  s.homepage    = "http://tanmer.com"
  s.summary     = "Summary of Decorator."
  s.description = "Description of Decorator."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
