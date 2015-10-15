$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "health_check/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "health_check"
  s.version     = HealthCheck::VERSION
  s.authors     = ["hirocaster"]
  s.email       = ["hohtsuka@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of HealthCheck."
  s.description = "TODO: Description of HealthCheck."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "sqlite3"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "json_spec"
  s.add_development_dependency "pry"
  s.add_development_dependency "fakeredis"
  s.add_development_dependency "rubocop"
end
