# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/bnm/version'

Gem::Specification.new do |spec|
  spec.name          = "bnm"
  spec.version       = Bnm::VERSION
  spec.authors       = ["fiveinfinity"]
  spec.email         = ["jlachance1@gmail.com"]

  spec.summary       = %q{Pitchfork's Best New Music including scores, articles, and links to Amoeba Music & Apple Music.}
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']

  spec.executables   << "bnm"
  spec.homepage      = "https://github.com/fiveinfinity/bnm-cli-gem.git"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "htmlentities", "~> 4.3"
  spec.add_development_dependency "faraday"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "colorize"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "bundler", "~> 1.11"
  spec.add_runtime_dependency "rake", "~> 11.0"
  spec.add_runtime_dependency "htmlentities", "~> 4.3"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "colorize"

end
