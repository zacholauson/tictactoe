describe Gamestate do
  describe "#initialize" do
    let(:gamestate) { Gamestate.new }

    it "should create a new board" do
      expect(gamestate.board).to eq(['-', '-', '-', '-', '-', '-', '-', '-', '-'])
    end

    it "should set the first move to 'x' for the computer" do
      expect(gamestate.turn).to eq("x")
    end

    it "should create a empty movelist to hold moves" do
      expect(gamestate.send(:movelist)).to eq([])
    end
  end

  describe "#move" do
    let(:gamestate) { create_gamestate_from_string("xo-o--x-x", turn: "o") }

    before do
      gamestate.stub(:movelist) {[0, 1, 8, 3, 6]}
    end

    it "should put an 'o' in the 4th index" do
      expect(gamestate.move(4).board).to eq(["x", "o", "-",
                                             "o", "o", "-",
                                             "x", "-", "x"])
    end
  end

  describe "#unmove" do
    let(:gamestate) { create_gamestate_from_string("xo-o--x-x", turn: "o") }

    before do
      gamestate.stub(:movelist) {[0, 1, 8, 3, 6, 4]}
    end

    it "should reset the last move on the board to '-'" do
      expect(gamestate.unmove.board).to eq(["x", "o", "-",
                                            "o", "-", "-",
                                            "x", "-", "x"])
    end
  end

  describe "#other_turn" do
    context "computers first" do
      let(:gamestate) { Gamestate.new }

      it "should return return 'o' if its computers turn" do
        expect(gamestate.other_turn).to eq("o")
      end
    end

    context "humans first" do
      let(:gamestate) { Gamestate.new(nil, "o") }

      it "should return return 'x' if its the humans turn" do
        expect(gamestate.other_turn).to eq("x")
      end
    end
  end

  describe "#possible_moves" do
    context "new game" do
      let(:gamestate) { Gamestate.new }

      it "should return the index of every available possition" do
        expect(gamestate.possible_moves).to eq([0,1, 2, 3, 4, 5, 6, 7, 8])
      end
    end

    context "game in progress" do
      let(:gamestate) { create_gamestate_from_string("xo-o--x-x") }

      it "should return the index of available positions in an array" do
        expect(gamestate.possible_moves).to eq([2, 4, 5, 7])
      end
    end
  end

  describe "#winning_positions" do
    let(:gamestate) { Gamestate.new }

    it "should return the indexes of every winning line ( horizontal, vertical, diagonal )" do
      expect(gamestate.winning_positions).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]])
    end
  end

  describe "#winning_lines" do
    context "new game" do
      let(:gamestate) { Gamestate.new }

      it "should return winnable line status' (horizontals, verticals, and diagonals)" do
        expect(gamestate.winning_lines).to eq([["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"],
                                               ["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"],
                                               ["-", "-", "-"], ["-", "-", "-"]])
      end
    end

    context "game in progress" do
      let(:gamestate) { create_gamestate_from_string("xo-o--x-x") }

      it "should return winnable lines status' (horizontals, verticals, and diagonals)" do
        expect(gamestate.winning_lines).to eq([["x", "o", "-"], ["o", "-", "-"], ["x", "-", "x"],
                                               ["x", "o", "x"], ["o", "-", "-"], ["-", "-", "x"],
                                               ["x", "-", "x"], ["-", "-", "x"]])
      end
    end
  end

  describe "#win?" do
    context "computer has won" do
      let(:gamestate) { create_gamestate_from_string("xo-ox-xox") }

      it "should return true if the computer ('x') has won" do
        expect(gamestate.win?("x")).to be_true
      end

    end

    context "no one has won" do
      let(:gamestate) { create_gamestate_from_string("xo-o--xox") }

      it "should return false if no one has won yet or tied" do
        expect(gamestate.win?("x")).to be_false
        expect(gamestate.win?("o")).to be_false
      end
    end
  end

  describe "#tied?" do
    let(:gamestate) { create_gamestate_from_string("xoxxoooxo") }

    it "should return true if the game is tied" do
      expect(gamestate.tied?).to be_true
    end
  end

  describe "#first_move?" do
    context "new game" do
      let(:gamestate) { Gamestate.new }

      it "should return true if no one has made a move" do
        expect(gamestate.first_move?).to be_true
      end
    end

    context "game in progress" do
      let(:gamestate) { create_gamestate_from_string("x-o-x-oxo") }

      before do
        gamestate.stub(:movelist) { [0, 2, 4, 6, 7, 8] }
      end

      it "should return false if previous moves have taken place" do
        expect(gamestate.first_move?).to be_false
      end
    end
  end

  describe "#game_over?" do
    let(:gamestate) { create_gamestate_from_string("xx-oxxoxo") }

    it "should return true if the game is over (winner / tie)" do
      expect(gamestate.game_over?).to be_true
    end
  end

  describe "#players_turn?" do
    let(:gamestate) { Gamestate.new(nil, "o") }

    it "should return true if it's the players turn" do
      expect(gamestate.players_turn?).to be_true
    end
  end

  describe "#computers_turn?" do
    let(:gamestate) { Gamestate.new }

    it "should return true if its the computers turn" do
      expect(gamestate.computers_turn?).to be_true
    end
  end

  describe "#set_players_turn" do
    let(:gamestate) { Gamestate.new }

    it "should set the gamestates turn to 'x' // the players turn" do
      gamestate.set_players_turn
      expect(gamestate.players_turn?).to be_true
    end
  end

  describe "#set_computers_turn" do
    let(:gamestate) { Gamestate.new(nil, "o") }

    it "should set the gamestates turn to 'o' // the computers turn" do
      gamestate.set_computers_turn
      expect(gamestate.computers_turn?).to be_true
    end
  end

  describe "#space_available?" do
    let(:gamestate) { create_gamestate_from_string("x-x-o-o-o") }

    it "should return true when the given index is an available position on the board" do
      expect(gamestate.space_available?(1)).to be_true
    end
  end
end
