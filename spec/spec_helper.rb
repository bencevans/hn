require "simplecov"
SimpleCov.start do
  add_filter 'spec'
end

require "open-uri"
require 'hn'

def fixture(filename)
  open("spec/fixtures/#{filename}") { |file| file.read }
end
