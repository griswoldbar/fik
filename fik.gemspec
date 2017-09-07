# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fik/version"

Gem::Specification.new do |spec|
  spec.name          = "fik"
  spec.version       = Fik::VERSION
  spec.authors       = ["Christopher Turtle"]
  spec.email         = ["chris@factory3.io"]

  spec.summary       = %q{blah}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-stack_explorer"
  
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "indefinite_article"
  spec.add_runtime_dependency "sinatra"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "curses"
  spec.add_runtime_dependency "thin"
  spec.add_runtime_dependency "faye"
  spec.add_runtime_dependency "faye-websocket"
  spec.add_runtime_dependency "private_pub"

end
