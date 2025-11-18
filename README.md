# Sprockets::ExportersPack

This gem aims to add some exporters to [sprockets][rails/sprockets].

Currently, it has:
- a Brotli exporter, which can be used with [ngx_brotli][google/ngx_brotli] and Caddy's [file_server.precompressed] subdirective.
- a Zstd exporter, which can be used with [zstd-nginx-module][tokers/zstd-nginx-module] and Caddy's [file_server.precompressed] subdirective.

## Installation

Add this line to your `Gemfile`:

```ruby
gem 'sprockets-exporters_zstd'
```

You probably need these too, as sprockets hasn't been updated yet:

```ruby
gem 'sprockets', '>= 4.0.0.beta3', github: 'rails/sprockets'
gem 'sprockets-rails', '>= 3.1.0'
```

```bash
$ bundle install
```

## Usage

With Rails, in `application.rb`:

```ruby
config.assets.configure do |env|
  # Brotli
  env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::ExportersPack::BrotliExporter
  # Zstd
  env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::ExportersPack::ZstdExporter
end
```

Without Rails:

```ruby
env = Sprockets::Environment.new
# Brotli
env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::ExportersPack::BrotliExporter
# Zstd
env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::ExportersPack::ZstdExporter
```

## Contributing

Yes please! Open an issue with exporters you want to see added.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[rails/sprockets]: https://github.com/rails/sprockets
[rails/rails]: https://github.com/rails/rails
[google/ngx_brotli]: https://github.com/google/ngx_brotli
[tokers/zstd-nginx-module]: https://github.com/tokers/zstd-nginx-module
[file_server.precompressed]: https://caddyserver.com/docs/caddyfile/directives/file_server#precompressed
