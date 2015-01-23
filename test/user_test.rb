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
      assert @user.has_game?(id: "400")
    end

    it "checks for a game by its short code" do
      assert @user.has_game?(short: "portal")
    end

    it "checks for an unowned game by id" do
      refute @user.has_game?(id: "202970")
    end

    it "checks for a list of games" do
      data = { "portal" => true, "400" => true }
      assert_equal data, @user.has_games?("portal,400")
    end

    it "checks for a list of unowned games" do
      data = { "portal" => true, "400" => true, "202970" => false }
      assert_equal data, @user.has_games?("portal,400,202970")
    end

    it "should redirect authentication to Steam" do
      get "/"
      assert last_response.redirect?
      follow_redirect!
      assert last_response.headers["Location"].starts_with?('https://steamcommunity.com/openid/login')
    end

    it "should return json" do
      get "/users/#{@user.id}"
      assert last_response.ok?, "Request Status: #{last_response.status}"
      assert_equal 'application/json', last_response.headers['Content-Type']
      assert_equal @user.id, JSON.parse(last_response.body)['id']
    end

    it "should return true/false for game list" do
      data = { "portal" => true, "400" => true, "202970" => false }
      get "/users/#{@user.id}/games?list=#{data.keys.join(',')}"
      assert last_response.ok?, "Request Status: #{last_response.status}"
      assert_equal 'application/json', last_response.headers['Content-Type']
      assert_equal data, JSON.parse(last_response.body)["games"]
    end
  end
end
