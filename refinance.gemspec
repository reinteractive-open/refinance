# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refinance/version'

Gem::Specification.new do |gem|
  gem.name = "refinance"
  gem.version = Refinance::VERSION
  gem.authors = ["reInteractive"]
  gem.email = ["enquiries@reinteractive.net"]
  gem.description = %q{A collection of finance algorithms related to annuities.}
  gem.summary = %q{Simple annuity algorithms}
  gem.homepage = "https://github.com/reinteractive-open/refinance"
  gem.license = "MIT"
  gem.required_ruby_version = ">= 1.9.3"

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake', '0.9.2.2'
  gem.add_development_dependency 'minitest', '3.5.0'
end
