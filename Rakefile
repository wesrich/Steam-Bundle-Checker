task(:default) { require_relative 'test/test' }

task :app => :dotenv do
  require_relative 'lib/app'
end

namespace :db do
  desc 'Run DB migrations'
  task :migrate => :app do
    require 'sequel/extensions/migration'

    Sequel::Migrator.apply(SteamApps.database, 'db/migrations')
  end
end