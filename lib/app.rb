require_relative 'steam'

class SteamApps < Sinatra::Base
  set :root, 'lib/app'

  get '/' do
    "Hello World"
  end
end
