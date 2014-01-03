require_relative "app/moveable"
require_relative "app/colorize"
require_relative "app/gamestate"
require_relative "app/display"
require_relative "app/human"
require_relative "app/ai"
require_relative "app/tictactoe"

gamestate = Gamestate.new
human     = Human.new(gamestate)
computer  = Ai.new(gamestate)
display   = Display.new(gamestate)

game_components = {gamestate: gamestate, human: human, computer: computer, display: display}

tictactoe = TicTacToe.new(game_components)
tictactoe.play_game
