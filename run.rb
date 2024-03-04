require "bundler/setup"
Bundler.require(:default, :development)

Dir[File.join(__dir__, 'app', '/**/*.rb')].sort { |a, b| a.count("/") <=> b.count("/")  }.each { |file| require file }

Application.new.run
