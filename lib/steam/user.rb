module Steam
  class User < Sequel::Model
    plugin :timestamps

    def self.from_auth(auth)
      User.find_or_create(uid: auth[:uid]) do |user|
        user.name = auth[:info][:nickname]
        user.avatar = auth[:info][:image]
        user.is_public = auth[:extra][:raw_info][:communityvisibilitystate] == 3
      end
    end

    def find_game(id: nil, short: nil)
      return game_list.values_at(id.to_s).first unless id.nil?
      game_list.select { |id, game| game == short }.keys.first
    end

    def has_game?(id: nil, short: nil)
      return game_list.key?(id) unless id.nil?
      game_list.value?(short)
    end

    def has_games?(list)
      list.split(",").map do |game|
        game[/\A\d+\z/] ? has_game?(id: game) : has_game?(short: game)
      end
    end

    def game_list
      JSON.parse(games)
    end

    def to_json(args)
      super args.merge({except: [:uid, :games]})
    end

    private

    def before_create
      fetch_games
      super
    end

    def account
      @account ||= SteamId.new(uid.to_i)
    end

    def fetch_games
      self.games = account.games.map { |app_id,game|
        [app_id, game.short_name]
      }.to_h.to_json
    end
  end
end
