# Unbeatable TicTacToe

This is a tic tac toe game that is playable through the command line and has an unbeatable ai.

## Gameplay

### To play the game run: `` ruby play.rb ``

### How to play:

1. When starting the game it will ask you for name and ask for who should go first.
2. Depending on who's turn it is, it will either ask for your move or the computer will decide what the best move is and move there.
3. Step 2 will be repeated, alternating who's turn it is, until the game either results in a win or tie.
4. When the game is finished it displays the result of the game and the final board.

### Notes:
##### When choosing who should go first:
If you want to go first type: ``human`` and hit enter

If you want the computer to go first type: ``computer`` and hit enter or just hit enter and it will default to the computer

##### When picking your next move:
To pick your next move insert the number shown in the box of your choosing

## App Layout
The app can be found in `` app/ ``

* ``` tictactoe.rb ``` is where the main logic of what happens next is coming from, it will display the board and ask the correct player for its move based on who's turn it is and then display the results of the game when it is finished.

*  ``` gamestate.rb ``` is where the the logic of the games state is, for example: check to see if someone has won or tied, positions on the board that results in a win, etc.

*   ``` display.rb ``` is where anything that is displayed to the command line comes from.

*   ``` ai.rb ``` is where the logic behind the the unbeatable ai is. Using the minimax algorithm it will play out every possible gamestate available from the current gamestate and then score the moves based on if it returns a win, loss, or tie. Using these returned scores it decides which move would be best.

*   ``` human.rb ``` only stores the humans name and handles human movement through the moveable module.

*   ``` moveable.rb ``` handles all movement for the human and ai.

*   ``` colorize.rb ``` this is just a string extension that wraps strings in a color sequence, there are many gems that do this but I thought it would be better to just extend string because I am only using 2 colors than having to install another gem. 
   
## Tests
To run the test suite with documentation:

`` rspec spec `` // default is documentation in `` .rspec ``

To run the test suite with the progress bar:

`` rspec spec --format progress ``

##### Note: The tests will take a while to run while testing the AI as it is playing out every possible game to make sure the AI is unbeatable
