require "webpacker_test"

class ManifestTest < Minitest::Test
  def test_file_path
    file_path = File.join(File.dirname(__FILE__), "test_app/public/webpack", "manifest.json").to_s
    assert_equal WebpackerLite::Manifest.file_path.to_s, file_path
  end

  def test_lookup_exception
    manifest_path = File.join(File.dirname(__FILE__), "test_app/public/webpack", "manifest.json").to_s
    asset_file = "calendar.js"
    msg = <<-MSG
        WebpackerLite can't find #{asset_file} in your manifest #{manifest_path}. Possible causes:
          1. You are hot reloading
          2. Webpack is not running
          3. You have misconfigured WebpackerLite's config/webpacker_lite.yml file.
          4. Your Webpack configuration is not creating a manifest.
    MSG

    error = assert_raises WebpackerLite::FileLoader::NotFoundError do
      WebpackerLite::Manifest.lookup(asset_file)
    end

    assert_equal error.message, msg
  end

  def test_lookup_success
    asset_file = "bootstrap.js"
    assert_equal WebpackerLite::Manifest.lookup(asset_file), "bootstrap-300631c4f0e0f9c865bc.js"
  end
end
