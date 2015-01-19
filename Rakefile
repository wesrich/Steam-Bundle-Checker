Bundler.require
require 'dotenv/tasks'
ENV['RACK_ENV'] ||= "development"

task(:default) { require_relative 'test/test' }

namespace :db do
  desc 'Run DB migrations'
  task :migrate => [:dotenv, :setup] do
    Sequel::Migrator.apply(@database, 'db/migrations')
  end

  task :setup do
    Sequel.extension :migration

    @database = Sequel.connect ENV['DATABASE_URL']
  end
end
