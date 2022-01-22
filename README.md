# Minesweeper

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
- create a version of this with a web gui
