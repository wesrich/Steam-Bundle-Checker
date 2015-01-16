module Steam
  class User < Sequel::Model
    attr_reader :account

    def initialize(id)
      @account = SteamId.new(id)
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
