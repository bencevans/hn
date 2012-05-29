require "simplecov"
SimpleCov.start do
  add_filter 'spec'
end

require 'hn'

require "fakeweb"
FakeWeb.allow_net_connect = false

require "open-uri"
def fixture(fixture_name)
  open("spec/fixtures/#{fixture_name}") { |p| p.read }
end