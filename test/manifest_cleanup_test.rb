require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require 'time'
require 'sprockets'
require 'sprockets/sidecar'

class ManifestCleanupTest < Minitest::Test
  def setup
    @directory = Dir.mktmpdir('sprockets-sidecar-test')
    @manifest = Sprockets::Manifest.new(@directory)
  end

  def teardown
    FileUtils.remove_entry(@directory)
  end

  def test_remove_deletes_all_compressed_siblings
    filename = add_asset('application-current.js', Time.now)
    @manifest.assets['application.js'] = filename

    @manifest.remove(filename)

    ['', '.gz', '.br', '.zst'].each do |extension|
      refute File.exist?(File.join(@directory, "#{filename}#{extension}"))
    end
    refute @manifest.files.key?(filename)
    refute @manifest.assets.key?('application.js')
  end

  def test_remove_tolerates_missing_compressed_siblings
    filename = add_asset('application-current.js', Time.now, compressed: false)

    @manifest.remove(filename)

    refute File.exist?(File.join(@directory, filename))
    refute @manifest.files.key?(filename)
  end

  def test_clean_preserves_current_and_two_backups
    now = Time.now
    obsolete = add_asset('application-obsolete.js', now - 18_000)
    backup_two = add_asset('application-backup-two.js', now - 14_400)
    backup_one = add_asset('application-backup-one.js', now - 10_800)
    current = add_asset('application-current.js', now - 7200)
    @manifest.assets['application.js'] = current

    @manifest.clean(2)

    [current, backup_one, backup_two].each do |filename|
      ['', '.gz', '.br', '.zst'].each do |extension|
        assert File.exist?(File.join(@directory, "#{filename}#{extension}"))
      end
      assert @manifest.files.key?(filename)
    end
    ['', '.gz', '.br', '.zst'].each do |extension|
      refute File.exist?(File.join(@directory, "#{obsolete}#{extension}"))
    end
    refute @manifest.files.key?(obsolete)
    assert_equal current, @manifest.assets['application.js']
  end

  def test_clean_preserves_recent_assets_beyond_backup_limit
    now = Time.now
    current = add_asset('application-current.js', now - 7200)
    recent = add_asset('application-recent.js', now - 60)
    @manifest.assets['application.js'] = current

    @manifest.clean(0)

    ['', '.gz', '.br', '.zst'].each do |extension|
      assert File.exist?(File.join(@directory, "#{recent}#{extension}"))
    end
    assert @manifest.files.key?(recent)
  end

  private

  def add_asset(filename, timestamp, compressed: true)
    @manifest.files[filename] = {
      'logical_path' => 'application.js',
      'mtime' => timestamp.iso8601
    }
    extensions = compressed ? ['', '.gz', '.br', '.zst'] : ['']
    extensions.each do |extension|
      File.write(File.join(@directory, "#{filename}#{extension}"), 'asset')
    end
    filename
  end
end