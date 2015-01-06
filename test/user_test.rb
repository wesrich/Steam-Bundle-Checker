describe User do
  before do
    @user = User.find(id: ENV['STEAM_USER'])
  end

  it "should have a list of games" do
    assert @user.games
    assert_equal ENV['GAME_COUNT'].to_i, @user.games.count
  end
end
