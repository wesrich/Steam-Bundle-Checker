ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
$:.unshift File.expand_path("./../lib", __FILE__)

require 'bundler'
Bundler.require
Dotenv.load

require_relative '../lib/app.rb'

# module Steam
  include Rack::Test::Methods
# end

require_relative 'user_test'

def app
  Steam::SteamApps
end
