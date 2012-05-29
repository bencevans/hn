# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hn/version', __FILE__)
require File.expand_path('../lib/hn/common', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Forrest Ye"]
  gem.email         = ["afu@forresty.com"]
  gem.description   = HackerNews::DESCRIPTION
  gem.summary       = HackerNews::DESCRIPTION
  gem.homepage      = "https://github.com/forresty/hn"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "hn"
  gem.require_paths = ["lib"]
  gem.version       = HackerNews::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'chronic'
  gem.add_development_dependency 'fakeweb'

  gem.add_runtime_dependency 'nokogiri'
end
