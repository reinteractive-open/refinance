# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refinance/version'

Gem::Specification.new do |spec|
  spec.name = 'refinance'
  spec.version = Refinance::VERSION
  spec.author = 'Reinteractive'
  spec.email = 'enquiries@reinteractive.net'
  spec.description = %q{A collection of finance algorithms related to annuities.}
  spec.summary = %q{Simple annuity algorithms}
  spec.homepage = 'https://github.com/reinteractive-open/refinance'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 1.9.3'
  spec.platform = Gem::Platform::RUBY

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake', '10.3.2'
  spec.add_development_dependency 'minitest', '5.4.1'
  spec.add_development_dependency 'bigdecimal', '1.2.5'
end
