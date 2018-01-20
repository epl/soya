lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "soya/version"

Gem::Specification.new do |s|
  # <http://guides.rubygems.org/specification-reference/>
  s.name          = 'soya'
  s.summary       = 'YAML/JSON file toolkit'
  s.description   = 'Handle YAML/JSON in a Unix-like manner, designed to assist in deployment and configuration management'
  s.version       = Soya::VERSION
  s.authors       = ['Edmund Lam']
  s.platform      = Gem::Platform::RUBY
  s.license       = 'GPL-3.0'
  s.homepage      = 'https://github.com/epl/soya'
  s.files         = %w[
    .rspec
    .ruby-version
    Gemfile
    Gemfile.lock
    LICENSE
    README.md
    soya.gemspec
    TODO.md
  ] + Dir['bin/*', 'doc/*', 'lib/**/*', 'spec/**/*']
  s.executables   = ['soya']
  s.require_paths = ['lib']
  s.add_runtime_dependency 'safe_yaml', '>= 1.0.4'
  s.add_development_dependency('bundler', '>= 1.15')
  s.add_development_dependency('rake', '>= 12.0')
end
