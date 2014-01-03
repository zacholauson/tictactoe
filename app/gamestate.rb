class Gamestate
  attr_accessor :board, :turn, :movelist

  def initialize(board = nil, turn="x")
    @board = board || Array.new(9, "-")
    @turn = turn
    @movelist = []
  end

  def other_turn
    @turn == "x" ? "o" : "x"
  end

  def possible_moves
    @board.map.with_index { |piece, index| piece == "-" ? index : nil }.compact
  end

  def winning_positions
    # rows                            #columns                         #diagonals
    [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  end

  def winning_lines
    winning_positions.map do |line|
      line.map {|line_index| @board[line_index]}
    end
  end

  def win?(piece)
    winning_lines.any? do |line|
      line.all? { |line_piece| line_piece == piece }
    end
  end

  def tied?
    winning_lines.all? do |line|
      line.any? { |line_piece| line_piece == "x" } && line.any? { |line_piece| line_piece == "o" }
    end
  end

  def first_move?
    @movelist.empty?
  end

  def game_over?
    win?("x") || win?("o") || @board.count("-") == 0
  end

  def players_turn?
    @turn == "o"
  end

  def computers_turn?
    @turn == "x"
  end

  def space_available?(index)
    @board[index] == "-"
  end
end

