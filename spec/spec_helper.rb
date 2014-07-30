if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
require 'simplecov'
SimpleCov.start

require 'webmock'
require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  WebMock.allow_net_connect!
end

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$ROOT = File.expand_path('../..', __FILE__)

require 'pry'
require 'rspec/its'
require 'rspec/matchers'
require 'equivalent-xml'
require 'rnfse'

Dir[File.join(File.expand_path(File.dirname(__FILE__)), "support", "**", "*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end
