require_relative 'steam'

class SteamApps < Sinatra::Base
  set :root, 'lib/app'

  configure do
    DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/database.sqlite3')
  end

  get '/' do
    "Hello World"
  end
end
