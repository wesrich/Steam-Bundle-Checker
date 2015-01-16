require 'sinatra/json'
require_relative 'steam'

class SteamApps < Sinatra::Base
  set :root, 'lib/app'

  configure do
    enable :sessions
    DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/database.sqlite3')

    use OmniAuth::Builder do
      provider :steam, ENV['STEAM_KEY']
    end
  end

  helpers do
    def current_user
      !session[:uid].nil?
    end
  end

  before do
    pass if require.path_info =~ /^\/auth\//

    redirect to('/auth/steam') unless current_user
  end

  get '/' do
    json session[:uid]
  end

  post '/auth/steam/callback' do
    session[:uid] = env['omniauth.auth']['uid']
    redirect to('/')
  end

  get '/auth/failure' do
  end
end
