module Steam
  class User < Sequel::Model
    plugin :timestamps

    def account
      @account ||= SteamId.new(uid)
    end

    def self.from_auth(auth)
      User.find_or_create(uid: auth[:uid]) do |user|
        user.name = auth[:info][:nickname]
        user.avatar = auth[:info][:image]
        user.is_public = auth[:extra][:raw_info][:communityvisibilitystate] == 3
      end
    end

    # def self.find(id: nil)
    #   User.new(id)
    # end

    def games
      @account.games
    end

    def find_game(id: nil, short: nil)
      return games[id] unless id.nil?
      games.select { |id, game| game.short_name == short }.values.first
    end

    def has_game?(id: nil, short: nil)
      find_game(id: id, short: short).is_a? SteamGame
    end
  end
end
