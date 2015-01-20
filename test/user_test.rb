module Steam
  describe User do
    before do
      @user = User.find(id: ENV['STEAM_USER'])
    end

    it "should have a list of games" do
      assert @user
      assert @user.games.is_a?(Hash)
    end

    it "returns a game by its id" do
      game = @user.find_game(id: 400)
      assert game
      assert_equal "Portal", game.name
    end

    it "returns a game by its short code" do
      game = @user.find_game(short: "portal")
      assert game
      assert_equal 400, game.app_id
    end

    it "checks for a game by its id" do
      assert @user.has_game?(id: 400)
    end

    it "checks for a game by its short code" do
      assert @user.has_game?(short: "portal")
    end

    it "should return json" do
      get "/id/#{ENV['STEAM_USER']}"
      last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
    end

    it "should return true/false for game list" do
      skip
    end
  end
end
