module WebpackerLite
  def self.bootstrap
    WebpackerLite::Env.load
    WebpackerLite::Configuration.load
    WebpackerLite::Manifest.load
  end

  def env
    WebpackerLite::Env.current.inquiry
  end
end

require "webpacker_lite/railtie" if defined?(Rails)
