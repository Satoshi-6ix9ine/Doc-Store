# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'looop_docstore/version'
Gem::Specification.new do |spec|
  spec.name          = "looop_docstore"
  spec.version       = Docstore::VERSION
  spec.authors       = ["Kevin Xu"]
  spec.email         = ["kevin@looop-in.com"]
  spec.license       = "MIT"
  spec.platform      = Gem::Platform::RUBY
  spec.summary       = %q{Looop api Document store gem.}
  spec.description   = %q{Restful api auth component interfaced with auth-service for authentication related tasks between internal services.}
  spec.homepage      = "http://looop-gem-server.api.looop.in"
  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://looop-gem-server.api.looop.in"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "aws-sdk-core", "~> 2"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "geminabox", "~> 0.13.1"
end
