$:.unshift File.expand_path("./../lib", __FILE__)

require 'bundler'
Bundler.require

require 'app'
ENV['RACK_ENV'] ||= 'development'

run Steam::SteamApps
