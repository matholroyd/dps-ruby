lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dps/version"

Gem::Specification.new do |spec|
  spec.name          = "dps"
  spec.version       = DPS::VERSION
  spec.authors       = ["Mat Holroyd"]
  spec.email         = ['dps@matholroyd.com']

  spec.summary       = %q{DPS is a collection of tools to help interact with or implement a DPS server}
  spec.description   = %q{Direct Payment Standard (DPS) specifies a common way for entities to advertise payment options as well as facilitate payments directly between 2 parties. This library contains tools to interact with or implement a DPS server.}
  spec.homepage      = "https://github.com/matholroyd/dps-ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dnsruby", "~> 1.61"
  
  spec.add_development_dependency "bundler", "~> 1.17.a"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8"
end