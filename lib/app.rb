require 'sinatra/json'
require_relative 'steam'

module Steam
  class SteamApps < Sinatra::Base
    set :root, 'lib/app'

    configure do
      enable :sessions

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
      pass if request.path_info =~ /^\/auth\//

      redirect to('/auth/steam') unless current_user
    end

    get '/' do
      json session[:uid]
    end

    post '/auth/steam/callback' do
      session[:uid] = env['omniauth.auth']['uid']
      # json env['omniauth.auth']
      redirect to('/')
    end

    get '/auth/failure' do
    end
  end
end
