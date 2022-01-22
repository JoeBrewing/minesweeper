# Minesweeper

There's a lot that could be refactored in this. Some of the nested if/elsif should be refactored into case statements
or utility methods. Definitely need to reduce the cycolmatic complexity.

# How To Play
- clone the project
- cd minesweeper
- ruby ./game.rb
- enter the height of the grid
- enter the width of the grid
- enter the number of bombs
- enter s to select a space followed by the x,y coordinates when prompted (0,0 is top left and height, width is bottom right)
- enter f to flag a mine followed by the x,y coordinates when prompted (0,0 is top left and height, width is bottom right)
- enter c to enable cheat mode
- enter x to exit the game

# Run Unit Tests (There's not 100% coverage)
- gem install rspec (if it's not already installed)
- rspec .\grid.rb  

# ToDo
- add more unit tests
- add logic to clear out adjacent regular squares when you select a regular square
- create a version of this with a web gui
