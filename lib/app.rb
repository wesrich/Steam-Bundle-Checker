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
      response["Access-Control-Allow-Origin"] = "*"
      pass if request.path_info =~ /^\/(auth|users)\//

      redirect to('/auth/steam') unless current_user
    end

    get '/' do
      json User.where(uid: session[:uid]).first
    end

    post '/auth/steam/callback' do
      session[:uid] = env['omniauth.auth']['uid']
      # json env['omniauth.auth']
      user = User.from_auth(env['omniauth.auth'])
      redirect to("/users/#{user.id}")
    end

    get '/auth/failure' do
    end

    get '/users/:user_id' do
      json User.find(id: params[:user_id])
    end

    get '/users/:user_id/games' do
      user = User.find(id: params[:user_id])
      json({ games: user.has_games?(params[:list]) })
    end
  end
end
