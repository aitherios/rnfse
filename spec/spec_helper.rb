require 'simplecov'
SimpleCov.start

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rspec/its'
require 'rnfse'

Dir[File.join(File.expand_path(File.dirname(__FILE__)), "support", "**", "*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end
