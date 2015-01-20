module Steam
  describe User do
    before do
      @auth_data = {
        uid: ENV['STEAM_USER'],
        info: {
          nickname: "wes",
          image: "http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/a9/a91db454e023deb32d1b7fa8ae78b7b9ca6603f8_medium.jpg"
        },
        extra: {
          raw_info: { communityvisibilitystate: 3 }
        }
      }
      User.from_auth(@auth_data).destroy
      @user = User.from_auth(@auth_data)
    end

    it "exists" do
      assert @user
    end

    it "should have a list of games" do
      assert @user.game_list.is_a?(Hash)
    end

    it "returns a game by its id" do
      game = @user.find_game(id: 400)
      assert game
      assert_equal "portal", game
    end

    it "returns a game by its short code" do
      game = @user.find_game(short: "portal")
      assert game
      assert_equal "400", game
    end

    it "checks for a game by its id" do
      assert @user.has_game?(id: 400)
    end

    it "checks for a game by its short code" do
      assert @user.has_game?(short: "portal")
    end

    it "should redirect authentication to Steam" do
      get "/"
      assert last_response.redirect?
      follow_redirect!
      assert last_response.headers["Location"].starts_with?('https://steamcommunity.com/openid/login')
    end

    it "should return json" do
      skip "NYI"
      get "/id/#{@user.id}"
      assert last_response.ok?
      assert_equal 'application/json;charset=utf-8', last_response.headers['Content-Type']
    end

    it "should return true/false for game list" do
      skip "NYI"
    end
  end
end
