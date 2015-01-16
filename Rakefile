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

    if ENV['RACK_ENV'] == 'production'
      @database = Sequel.postgres ENV['DATABASE_URL']
    else
      @database = Sequel.sqlite "db/#{ENV['RACK_ENV']}.sqlite3"
    end
  end
end
