require 'sprockets/exporters/base'
require 'zstd-ruby'

module Sprockets
  module ExportersPack
    class ZstdExporter < ::Sprockets::Exporters::Base
      def setup
        @zstd_target = "#{ target }.zst"
      end

      def skip?(logger)
        if ::File.exist?(@zstd_target)
          logger.debug "Skipping #{ @zstd_target }, already exists"
          true
        else
          logger.info "Writing #{ @zstd_target }"
          false
        end
      end

      def call
        data = File.binread(target)
        zstd = Zstd.compress(data, level: self.class.quality)

        write(@zstd_target) do |file|
          file.write(zstd)
          file.close
        end
      end

      class << self
        attr_writer :quality

        def quality
          @quality || 9
        end
      end
    end
  end
end
