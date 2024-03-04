require "bundler/setup"
Bundler.require(:default)

Dir[File.join(__dir__, '..', '/app', '/**/*.rb')].sort { |a, b| a.count("/") <=> b.count("/")  }.each { |file| require file }
