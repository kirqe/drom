# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "drom/version"

Gem::Specification.new do |spec|
  spec.name          = "drom"
  spec.version       = Drom::VERSION
  spec.authors       = ["kirqe"]
  spec.email         = ["railsr@yahoo.com"]

  spec.summary       = %q{Fetching and parsing listings from drom.ru}
  spec.description   = %q{Ruby gem for fetching and parsing listing from drom.ru}
  spec.homepage      = "https://github.com/kirqe/drom"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "httparty", "~> 0.15.6"
  spec.add_dependency "nokogiri", "~> 1.8"
  spec.add_dependency "whirly", "~> 0.2.4"
end
