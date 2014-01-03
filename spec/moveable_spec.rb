describe Moveable do
  let(:gamestate) { create_gamestate_from_string("xo-o--x-x", turn: "o") }
  let(:human) { Human.new(gamestate) }

  before do
    gamestate.movelist = [0, 1, 8, 3, 6]
  end

  describe "#move" do
    it "should put an 'o' in the 4th index" do
      expect(human.move(4, gamestate).board).to eq(["x", "o", "-",
                                                    "o", "o", "-",
                                                    "x", "-", "x"])
    end

    it "should set the gamestates turn to the computer after moving" do
      expect(human.move(4, gamestate).turn).to eq("x")
    end

    it "should add the last move to the gamestates movelist" do
      expect(human.move(4, gamestate).movelist).to eq([0, 1, 8, 3, 6, 4])
    end
  end

  describe "#unmove" do
    it "should reset the last move on the board to '-'" do
      expect(human.unmove(gamestate).board).to eq(["x", "o", "-",
                                                   "o", "-", "-",
                                                   "-", "-", "x"])
    end

    it "should set the gamestates turn to the next player" do
      expect(human.unmove(gamestate).turn).to eq("x")
    end

    it "should remove the last move from the movelist" do
      expect(human.unmove(gamestate).movelist).to eq([0, 1, 8, 3])
    end
  end
end
