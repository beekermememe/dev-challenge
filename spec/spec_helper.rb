require 'simplecov'


RSpec.configure do |config|
  SimpleCov.start
  config.mock_framework = :mocha
end