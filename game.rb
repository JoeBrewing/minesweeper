require_relative('grid')

class Game 
  # This class controls the game.

  # Start the game on initialization.
  def initialize
    play
  end

  # This is the main game play method. 
  def play
    # Prompt the user for the grid height.
    height = get_value('Input the grid height: ').to_i

    # Prompt the user for the grid width.
    width = get_value('Input the grid width: ').to_i

    # Prompt the user for the bomb count.
    bomb_count = get_value('Input the number of bombs: ').to_i

    # Instantiate the grid.
    grid = Grid.new(height, width, bomb_count)

    # Start the game loop.
    game_loop(grid)
  end

  # This is the main game play loop method. It will loop until the player has lost or won.
  def game_loop(grid)
    lost = false
    won = false
    leave = false

    while lost == false && won == false && leave == false do
      # Display how many flags there are left to place.
      grid.flags_left_message 

      # Draw the grid
      grid.draw_grid

      # Ask to place flag or select sqaure.
      response = get_value('Enter (f) to place/remove a flag or (s) to select a square or (x) to exit.')

      # If response is 'x' then we leave early.
      if response == 'x'
        leave = true
      # If response if f then we ask for the flag x,y coordinates and perform flag placing logic.
      elsif response == 'f'
        # Get the coordinates to select.
        x, y = get_coordinates

        # Flag the square and find out whether or not the player won.
        won = grid.flag(x, y)
      elsif response == 's'
        # Get the coordinates to select.
        x, y = get_coordinates

        # Select the square and find out whether or not the player lost.
        lost = grid.select(x, y)
      end
    end

    # If the player has chosen to exit early then print thanks for playing.
    if leave 
      puts 'Thanks for playing!'
    end 

    # If the player lost then print that a bomb has been selected.
    if lost
      grid.draw_grid

      puts 'You have selected a bomb. Better luck next time!'
    end

    # If the player won then print that the player has won.
    if won  
      grid.draw_grid

      puts 'Congratulations! You won!'
    end
  end

  # Print the selected prompt and get the entered value.
  def get_value(prompt)
    puts prompt
    value = gets.chomp
  end

  # Get x,y coordinates from the player.
  def get_coordinates
    puts 'Enter the x value: '
    x = gets.chomp

    puts 'Enter the y value: '
    y = gets.chomp 

    [x,y]
  end
end

Game.new

