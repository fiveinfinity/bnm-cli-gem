# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/bnm/version'

Gem::Specification.new do |spec|
  spec.name          = "bnm"
  spec.version       = Bnm::VERSION
  spec.authors       = ["fiveinfinity"]
  spec.email         = ["jlachance1@gmail.com"]

  spec.summary       = %q{Pitchfork's Best New Music including scores, articles, and links to Amoeba Music.}
  spec.license       = "MIT"

  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files         = Dir['lib/**/*.rb'] + Dir['bin/*']
  spec.executables   = ["bnm"]
  spec.homepage      = "https://github.com/fiveinfinity/bnm-cli-gem.git"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "htmlentities", "~> 4.3"
  spec.add_development_dependency "launchy", '~> 0'
  spec.add_development_dependency "faraday"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
end
