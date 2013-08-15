# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ares_client/version'

Gem::Specification.new do |spec|
  spec.name          = "ares_client"
  spec.version       = AresClient::VERSION
  spec.authors       = ["Jiri Kubicek"]
  spec.email         = ["jiri.kubicek@kraxnet.cz"]
  spec.description   = %q{Simple ARES Client / Parser}
  spec.summary       = %q{This gem uses API to access data from Czech Register of Economic Subjects (ARES MFCR - http://http://wwwinfo.mfcr.cz)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

  spec.add_dependency "httparty"
end
