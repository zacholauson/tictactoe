def create_gamestate_from_string(board_string, options = {})
  board = board_string.split(//)
  options[:turn] ? Gamestate.new(board, options[:turn]) : Gamestate.new(board)
end

def create_game(board = Array.new(9, '-'), turn = "x")
  gamestate = Gamestate.new(board, turn)
  computer = Ai.new(gamestate)
  return gamestate, computer
end

def possible_moves(board)
  board.map.with_index { |piece, index| piece == "-" ? index : nil }.compact
end

def playout_every_move(gamestate, computer)
  if gamestate.computers_turn?
    computers_move = computer.decide_move
    gamestate.move(computers_move)
    return true if gamestate.game_over?
  end

  possible_moves(gamestate.board).map do |possible_move|
    new_gamestate, new_computer = create_game(gamestate.board.dup, "o")
    new_gamestate.move(possible_move)

    if new_gamestate.win?("o")
      return false
    elsif new_gamestate.game_over?
      return true
    else
      playout_every_move(new_gamestate, new_computer)
    end
  end
end
