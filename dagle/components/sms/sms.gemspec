$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sms"
  s.version     = Sms::VERSION
  s.authors     = ["xiaohui"]
  s.email       = ["xiaohui@zhangxh.net"]
  s.homepage    = "http://tanmer.com"
  s.summary     = "Summary of Sms."
  s.description = "Description of Sms."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "redis"
  s.add_dependency 'rest-client', '~> 2.0'
  s.required_ruby_version = '~> 2.0'
end
