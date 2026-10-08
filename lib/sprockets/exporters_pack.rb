require 'sprockets/exporters_pack/version'
require 'sprockets/exporters_pack/brotli_exporter'
require 'sprockets/exporters_pack/zstd_exporter'
require 'sprockets/manifest'

module Sprockets
  module ExportersPack
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

Sprockets::Manifest.prepend(Sprockets::ExportersPack::ManifestCleanup)
