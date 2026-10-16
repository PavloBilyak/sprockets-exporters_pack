# Sprockets::Sidecar

Writes precompressed sidecar files (`.br`, `.zst`) next to [sprockets][rails/sprockets] assets.

This is a fork of [sprockets-exporters_pack][hansottowirtz/sprockets-exporters_pack] gem that adds support of Zstd compression and asset cleanup.

Currently, it has:

- a Brotli exporter, which can be used with Nginx [ngx_brotli][google/ngx_brotli] module and Caddy [file_server.precompressed] subdirective.
- a Zstd exporter, which can be used with Nginx [zstd-nginx-module][tokers/zstd-nginx-module] module and Caddy [file_server.precompressed] subdirective.

## Installation

Add this line to your `Gemfile`:

```ruby
gem 'sprockets-sidecar'
```

If you used `sprockets-exporters_pack` before, remove it from your `Gemfile` and replace `Sprockets::ExportersPack` with `Sprockets::Sidecar`.

You probably need these too, as sprockets hasn't been updated yet:

```ruby
gem 'sprockets', '>= 4.0.0.beta3', github: 'rails/sprockets'
gem 'sprockets-rails', '>= 3.1.0'
```

```bash
bundle install
```

## Usage

With Rails, in `application.rb`:

```ruby
config.assets.configure do |env|
  # Brotli
  env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::Sidecar::BrotliExporter
  # Zstd
  env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::Sidecar::ZstdExporter
end
```

Without Rails:

```ruby
env = Sprockets::Environment.new
# Brotli
env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::Sidecar::BrotliExporter
# Zstd
env.register_exporter %w(text/css application/javascript image/svg+xml), Sprockets::Sidecar::ZstdExporter
```

## Contributing

Yes please! Open an issue with exporters you want to see added.

## Tests

```bash
bundle install
bundle exec rake
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[rails/sprockets]: https://github.com/rails/sprockets
[hansottowirtz/sprockets-exporters_pack]: https://github.com/hansottowirtz/sprockets-exporters_pack
[rails/rails]: https://github.com/rails/rails
[google/ngx_brotli]: https://github.com/google/ngx_brotli
[tokers/zstd-nginx-module]: https://github.com/tokers/zstd-nginx-module
[file_server.precompressed]: https://caddyserver.com/docs/caddyfile/directives/file_server#precompressed
