require 'stringio'

describe Display do
  describe "#ask_human_for_name" do
    let(:gamestate) { Gamestate.new }
    let(:human) { Human.new(gamestate) }
    let(:output) { StringIO.new }
    let(:display) { Display.new(gamestate, output) }

    before do
      display.stub(:gets).and_return('Zach')
    end

    it "should thank you for entering your name" do
      display.send(:ask_human_for_name, human)
      output.seek(0)
      expect(output.read).to eq("What is your name? Thanks Zach\n")
    end
  end

  describe "#ask_for_who_should_go_first" do
    let(:gamestate) { Gamestate.new }
    let(:human) { Human.new(gamestate) }
    let(:output) { StringIO.new }
    let(:display) { Display.new(gamestate, output) }

    before do
      display.stub(:gets).and_return('computer')
    end

    it "should ask who should go first" do
      display.send(:ask_for_who_should_go_first)
      output.seek(0)
      expect(output.read).to eq("Who should go first ( computer | human )? \n")
    end

    context "enter computer should go first" do
      before do
        display.stub(:gets).and_return('computer')
        display.send(:ask_for_who_should_go_first)
      end

      it "should set the gamestates turn to 'x'" do
        expect(gamestate.turn).to eq("x")
      end
    end

    context "press enter and use default" do
      before do
        display.stub(:gets).and_return('')
        display.send(:ask_for_who_should_go_first)
      end

      it "should set the gamestates turn to 'x' by default if no answer is put in" do
        expect(gamestate.turn).to eq("x")
      end
    end

    context "enter human should go first" do
      before do
        display.stub(:gets).and_return('human')
        display.send(:ask_for_who_should_go_first)
      end

      it "should set the gamestates turn to 'o'" do
        expect(gamestate.turn).to eq("o")
      end
    end
  end

  describe "#ask_for_move" do
    let(:gamestate) { create_gamestate_from_string("xoxo--xxo", turn: "o") }
    let(:human) { Human.new(gamestate) }
    let(:output) { StringIO.new }
    let(:display) { Display.new(gamestate, output) }

    before do
      display.stub(:gets).and_return('4')
    end

    it "should ask for your move" do
      display.ask_for_move
      output.seek(0)
      expect(output.read).to eq("\nMove: \n")
    end

    it "should return the index of the chosen position when that position is available" do
      expect(display.ask_for_move).to eq(4)
    end
  end

  describe "#colorize_piece" do
    let(:gamestate) { Gamestate.new }
    let(:display) { Display.new(gamestate) }

    it "should return a red colorized 'x'" do
      expect(display.send(:colorize_piece, "x")).to eq("\e[31mx\e[0m")
    end

    it "should return a green colorized 'o'" do
      expect(display.send(:colorize_piece, "o")).to eq("\e[32mo\e[0m")
    end
  end

  describe "#clear_screen" do
    let(:gamestate) { Gamestate.new }
    let(:output) { StringIO.new }
    let(:display) { Display.new(gamestate, output) }

    it "should clear the screen" do
      display.clear_screen
      output.seek(0)
      expect(output.read).to eq("\e[H\e[2J\n")
    end
  end

  describe "#new_line" do
    let(:gamestate) { Gamestate.new }
    let(:output) { StringIO.new }
    let(:display) { Display.new(gamestate, output) }

    it "should put a new line" do
      display.new_line
      output.seek(0)
      expect(output.read).to eq("\n")
    end
  end

  describe "#board" do
    let(:gamestate) { create_gamestate_from_string("xoxx--oo-", turn: "o") }
    let(:output) { StringIO.new }
    let(:display) { Display.new(gamestate, output) }

    before do
      gamestate.movelist = [0, 3, 1, 2, 6, 7]
    end

    it "should display the board of the current gamestate" do
      display.board
      output.seek(0)
      expect(output.read).to eq("\e[H\e[2J\n \e[31mx\e[0m | \e[32mo\e[0m | \e[31mx\e[0m \n-----------\n \e[31mx\e[0m | 4 | 5 \n-----------\n \e[32mo\e[0m | \e[32mo\e[0m | 8 \n")
    end
  end

  describe "#other_player" do
    context "computer's turn" do
      let(:gamestate) { create_gamestate_from_string("xoxx--oo-", turn: "x") }
      let(:display) { Display.new(gamestate) }

      it "should return Human as the other player when its the computers turn" do
        expect(display.send(:other_player)).to eq("Human")
      end
    end

    context "human's turn" do
      let(:gamestate) { create_gamestate_from_string("xoxx--oo-", turn: "o") }
      let(:display) { Display.new(gamestate) }

      it "should return Computer as the other player when its the humans turn" do
        expect(display.send(:other_player)).to eq("Computer")
      end
    end
  end

  describe "#results" do
    context "game tied" do
      let(:gamestate) { create_gamestate_from_string("xoxoxooxo") }
      let(:output) { StringIO.new }
      let(:display) { Display.new(gamestate, output) }

      it "should return print out the game tied in red" do
        display.results
        output.seek(0)
        expect(output.read).to eq("\e[H\e[2J\n\e[31mTied\e[0m\n\n\n")
      end
    end

    context "computer won" do
      let(:gamestate) { create_gamestate_from_string("xoxoxooox", turn: "o") }
      let(:output) { StringIO.new }
      let(:display) { Display.new(gamestate, output) }

      it "should print out that the computer won in red and the winning board" do
        display.results
        output.seek(0)
        expect(output.read).to eq("\e[H\e[2J\n\e[31mWinner: Computer\e[0m\n\n \e[31mx\e[0m | \e[32mo\e[0m | \e[31mx\e[0m \n-----------\n \e[32mo\e[0m | \e[31mx\e[0m | \e[32mo\e[0m \n-----------\n \e[32mo\e[0m | \e[32mo\e[0m | \e[31mx\e[0m \n\n")
      end
    end
  end
end
