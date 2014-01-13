class Display
  def initialize(gamestate, output = STDOUT)
    @gamestate = gamestate
    @output = output
  end

  def board
    board_with_indices = fill_empty_spaces_with_indices
    formatted_board = format(board_with_indices)

    clear_screen unless @gamestate.game_over?
    @output.puts formatted_board unless (@gamestate.first_move? && @gamestate.computers_turn?) || @gamestate.computers_turn?
  end

  def results
    clear_screen
    @output.puts @gamestate.tied? ? "Tied".red : "Winner: #{other_player}".red
    new_line
    board
    new_line
  end

  def setup_human(human)
    ask_human_for_name(human)
    ask_for_who_should_go_first
  end

  def ask_for_move
    new_line
    @output.print "Move: "
    move = gets.chomp
    new_line
    return move.to_i if move =~ /^\d+$/ && @gamestate.space_available?(move.to_i)
    @output.puts "Invalid Move"
    ask_for_move
  end

  private

  def clear_screen
    @output.puts "\e[H\e[2J"
  end

  def new_line
    @output.puts
  end

  def ask_human_for_name(human)
    @output.print "What is your name? "
    name = gets.chomp.capitalize
    name ? (@output.puts "Thanks #{name}" ; human.set_name(name)) : ask_for_name
  end

  def ask_for_who_should_go_first
    @output.print "Who should go first ( computer | human )? "
    who_goes_first = gets.chomp
    new_line
    who_goes_first.include?("h") ? @gamestate.set_players_turn : @gamestate.set_computers_turn
  end

  def fill_empty_spaces_with_indices
    @gamestate.board.map.with_index{ | piece, index| piece == "-" ? index : piece }
  end

  def colorize_line(line)
    line.map{ |piece| (piece == "x" || piece == "o") ? colorize_piece(piece) : piece }
  end

  def format(board_with_indices)
    board_with_indices.each_slice(3).map{ |line| " " + colorize_line(line).join(" | ") + " "}.join("\n-----------\n") + "\n"
  end

  def colorize_piece(piece)
    piece == "x" ? piece.red : piece.green
  end

  def other_player
    @gamestate.turn == "o" ? "Computer" : "Human"
  end
end
