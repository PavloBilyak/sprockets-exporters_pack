require 'sprockets/sidecar/version'
require 'sprockets/sidecar/brotli_exporter'
require 'sprockets/sidecar/zstd_exporter'
require 'sprockets/manifest'

module Sprockets
  module Sidecar
    module ManifestCleanup
      def remove(filename)
        result = super
        path = File.join(directory, filename)
        FileUtils.rm_f(["#{path}.br", "#{path}.zst"])
        result
      end
    end
  end
end

Sprockets::Manifest.prepend(Sprockets::Sidecar::ManifestCleanup)
