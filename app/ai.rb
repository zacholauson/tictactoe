class Ai
  def initialize(gamestate)
    @gamestate = gamestate
  end

  def get_leaf_score
    return  1 if @gamestate.win?("x")
    return -1 if @gamestate.win?("o")
    return  0 if @gamestate.tied?
  end

  def minimax_for(index)
    @gamestate.move(index)

    leaf_score = get_leaf_score

    (@gamestate.unmove ; return leaf_score) if leaf_score

    scores = []

    @gamestate.possible_moves.each do |move_index|
      scores << minimax_for(move_index)
    end

    # if @gamestate.turn == "x"
    if @gamestate.computers_turn?
      @gamestate.unmove
      return scores.max
    else
      @gamestate.unmove
      return scores.min
    end
  end

  def decide_move
    return 0 if @gamestate.first_move?

    minimax_values = {}

    @gamestate.possible_moves.each do |move_index|
      minimax_values[move_index] = minimax_for(move_index)
    end

    best_move = minimax_values.each{ |key, value| return key if value == minimax_values.values.max }

    return best_move
  end
end
