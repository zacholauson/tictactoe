describe Ai do
  describe "#get_leaf_score" do
    context "computer wins" do
      let(:gamestate) { create_gamestate_from_string("xx-oxxoxo") }
      let(:computer) { Ai.new(gamestate) }

      it "should return 1 because 'x' won" do
        expect(computer.get_leaf_score).to eq(1)
      end
    end

    context "human wins" do
      let(:gamestate) { create_gamestate_from_string("x-oxoxo-o") }
      let(:computer) { Ai.new(gamestate) }

      it "should return -1 because the human won" do
        expect(computer.get_leaf_score).to eq(-1)
      end
    end

    context "game tied" do
      let(:gamestate) { create_gamestate_from_string("xoxxoxoxo") }
      let(:computer) { Ai.new(gamestate) }

      it "should return 0 because the game ended in a tie" do
        expect(computer.get_leaf_score).to eq(0)
      end
    end
  end

  describe "#minimax_for" do
    context "computer plays first" do
      before do
        @gamestate, @computer = create_game(nil, nil)
      end

      it "should return all true (computer won or tied) when computer plays first" do
        expect(playout_every_move(@gamestate, @computer).flatten.uniq.all?).to be_true
      end
    end

    context "human plays first" do
      before do
        @gamestate, @computer = create_game(nil, "o")
      end

      it "should return all true (computer won or tied) when human plays first" do
        expect(playout_every_move(@gamestate, @computer).flatten.uniq.all?).to be_true
      end
    end
  end

  describe "#decide_move" do
    let(:gamestate) { create_gamestate_from_string("xo-o--xox") }

    before do
      # Need to have moves in the movelist so that it will return
      # the right move and no 0 for the first move
      # gamestate.stub(:movelist) {[0, 1, 3, 6, 7, 8]}
      gamestate.movelist = [0, 1, 3, 6, 7, 8]
    end

    let(:computer) { Ai.new(gamestate) }

    it "should return the best move index based on current gamestate" do
      expect(computer.decide_move).to eq(4)
    end
  end
end
