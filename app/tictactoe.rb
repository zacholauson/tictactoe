class TicTacToe
  def initialize(options = {})
    begin
      @gamestate = options.fetch(:gamestate)
      @human     = options.fetch(:human)
      @computer  = options.fetch(:computer)
      @display   = options.fetch(:display)
    rescue
      raise "You need to pass a gamestate, a human, an ai, and a display to initialize a TicTacToe Game"
    end
  end

  def play_game
    @display.setup_human(@human)

    until @gamestate.game_over?
      @display.clear_screen
      @display.board
      update_gamestate_with_new_move(get_next_move)
    end

    @display.results
  end

  private

  def get_next_move
    @gamestate.players_turn? ? @display.ask_for_move : @computer.decide_move
  end

  def update_gamestate_with_new_move(index)
    @gamestate.players_turn? ? @human.move(index, @gamestate) : @computer.move(index, @gamestate)
  end
end

