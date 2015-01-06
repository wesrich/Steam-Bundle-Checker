ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
$:.unshift File.expand_path("./../lib", __FILE__)

require 'bundler'
Bundler.require

require_relative '../lib/app.rb'

include Rack::Test::Methods

require_relative 'user_test'
