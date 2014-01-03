module Moveable
  def move(index, gamestate)
    gamestate.board[index] = gamestate.turn
    gamestate.turn = gamestate.other_turn
    gamestate.movelist << index
    return gamestate
  end

  def unmove(gamestate)
    gamestate.board[gamestate.movelist.pop] = "-"
    gamestate.turn = gamestate.other_turn
    return gamestate
  end
end
