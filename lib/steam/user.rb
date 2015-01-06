class User
  attr_accessor :account

  def self.find(id: nil)
    @account = SteamId.new(id)
  end

  

end
