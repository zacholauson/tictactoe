describe TicTacToe do
  describe "#initialize" do
    it "should raise an exception if the proper arguments arent passed on initialization" do
      expect{TicTacToe.new}.to raise_error("You need to pass a gamestate, a human, an ai, and a display to initialize a TicTacToe Game")
    end
  end

  describe "#play_game" do
  end
end
