begin
  require 'simplecov'
rescue LoadError
  # ignore
else
  SimpleCov.start do
    add_group 'WOTC', 'lib/wotc'
    add_group 'Faraday Middleware', 'lib/faraday'
    add_group 'Specs', 'spec'
  end
end

require File.expand_path('../../lib/wotc', __FILE__)

require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include WebMock::API
end

def capture_output(&block)
  begin
    old_stdout = $stdout
    $stdout = StringIO.new
    block.call
    result = $stdout.string
  ensure
    $stdout = old_stdout
  end
  result
end

def a_delete(path)
  a_request(:delete, WTOC.endpoint + path)
end

def a_get(path)
  a_request(:get, WOTC.endpoint + path)
end

def a_post(path)
  a_request(:post, WOTC.endpoint + path)
end

def a_put(path)
  a_request(:put, WOTC.endpoint + path)
end

def stub_delete(path)
  stub_request(:delete, WOTC.endpoint + path)
end

def stub_get(path)
  stub_request(:get, WOTC.endpoint + path)
end

def stub_post(path)
  stub_request(:post, WOTC.endpoint + path)
end

def stub_put(path)
  stub_request(:put, WOTC.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
