describe User do
  before do
    @user = User.find(id: ENV['STEAM_USER'])
  end

  it "should have a list of games" do
    assert @user.games
  end
end
