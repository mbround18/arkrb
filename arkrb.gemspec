
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arkrb/version'

Gem::Specification.new do |spec|
  spec.name          = 'arkrb'
  spec.version       = Arkrb::VERSION
  spec.authors = ['Michael Bruno']
  spec.email = ['michael.bruno1337@gmail.com']

  spec.summary = 'This is a wrapper for ark server tools which is located at '
  spec.description = 'Gem wrapper for ark-server-tools'
  spec.homepage = 'https://github.com/mbround18/ark_rb'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org/'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'yard', '~> 0.9.12'
  spec.add_dependency 'oga', '~> 1.3', '>= 1.3.1'
  spec.add_runtime_dependency 'thor', '~> 0.20.0'
  spec.add_runtime_dependency 'colorize', '~> 0.8.1'

  spec.metadata['yard.run'] = 'yri'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'yard', '~> 0.9.12'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
