# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprockets/sidecar/version'

Gem::Specification.new do |spec|
  spec.name          = 'sprockets-sidecar'
  spec.version       = Sprockets::Sidecar::VERSION
  spec.authors       = ['Pavlo Bilyak', 'Hans Otto Wirtz']
  spec.email         = ['48239848+PavloBilyak@users.noreply.github.com']

  spec.summary       = 'Writes precompressed Brotli and Zstd sidecar files for Sprockets assets'
  spec.homepage      = 'https://github.com/PavloBilyak/sprockets-exporters_pack'
  spec.license       = 'MIT'

  spec.files         = Dir['README.md', 'LICENSE', 'lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.14'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'minitest', '>= 5.0'

  spec.add_dependency 'brotli', '>= 0.2.0'
  spec.add_dependency 'zstd-ruby', '~> 2.0'
  spec.add_dependency 'sprockets', '>= 4.0.0.beta3'
end
