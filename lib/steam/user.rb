class User
  attr_accessor :account

  def initialize(id)
    @account = SteamId.new(id)
  end

  def self.find(id: nil)
    User.new(id)
  end

  def games
    @account.games
  end

end
