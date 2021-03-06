require 'rspec'
require_relative 'square'
require_relative 'bomb'
require_relative 'bomb_adjacent'

class Grid
  # A class to manage the minesweeper grid.

  # Initialize the grid related values.
  def initialize(height, width, num_bombs = ((height + width) / 2))
    # Set the height.
    @height = height

    # Set the width.
    @width = width

    # Set the number of bombs.
    @num_bombs = num_bombs

    # Create the grid.
    @grid = create_grid

    # Place the bombs.
    place_bombs

    # Initialize the flag count.
    @flag_count = num_bombs

    # Initialize the flagged array
    @flagged = []
    
    # Place squares that are bomb adjacent.
    assign_bomb_adjacent

    # Initialize cheat mode as false.
    @cheat_mode = false
  end

  # This method creates the grid to the specified height and width.
  def create_grid
    # Initializes an empty array.
    arr = []
    
    # Loop for each row.
    @height.times do |y|
      # Initialize the row as an empty array.
      arr[y] = [] 
      
      # Loop through the width for each column.
      @width.times do |x|
        # Append a new `Square` to the row.
        arr[y] << Square.new(x, y)
      end
    end

    # Return the grid.
    arr
  end

  # Place the bombs on the grid.
  def place_bombs
    # Initialize the number of placed bombs to 0.
    placed_bombs = 0

    # Loop until the number of placed bombs matches the expected number of bombs.
    while placed_bombs < @num_bombs
      # Select a random x location.
      rand_x = rand(@width)

      # Select a random y location.
      rand_y = rand(@height)

      # Continue the loop if the randomly selected grid x,y location already
      # has a bomb.
      next if @grid[rand_y][rand_x].is_a?(Bomb)

      # Set the randomly selected grid x,y location as a bomb.
      @grid[rand_y][rand_x] = Bomb.new(rand_x, rand_y)

      # Increment the number of set bombs.
      placed_bombs += 1
    end
  end

  # Exposes the grid instance variable.
  def grid
    @grid
  end

  # This draws the grid
  def draw_grid
    # Loop through each grid row.
    grid.each do |row|
      # Print the row.
      puts row.map{ |x| x.draw(@cheat_mode) }.join(' | ')
    end
  end

  # This method selects the passed square and returns whether or not it is a bomb.
  def select(x, y)
    # Set clicked for the passed coordinates.
    grid[y.to_i - 1][x.to_i - 1].set_clicked
  end

  def flag(x, y)
    if @flag_count == 0
      # Print that there are no more flags to place and return early.
      puts 'There are no more flags to place. Check your current flag placements.'
      return
    end

    # Set flagged for the passed coordinates.
    flagged = grid[y.to_i - 1][x.to_i - 1].set_flagged

    if flagged 
      # Decrease the flag count by one.
      @flag_count -= 1
    else 
      # Increase the flag count by one because a flag has been removed.
      @flag_count += 1
    end

    # Return true if the win condition has been achieved. Otherwise return false.
    return check_for_win_condition
  end

  # This checks to see if the game has been won.
  def check_for_win_condition
    # Return early if there are still flags to place.
    return false if @flag_count > 0

    # Return true if all the flagged squares are bombs. Otherwise return false.
    return @flagged.select{ |x| !x.is_a?(Bomb) }.count == 0
  end

  # Initializes the squares that are adjacent to a bomb.
  def assign_bomb_adjacent
    # Loop through each row.
    grid.each do |row|
      # Loop through each square in the row.
      row.each do |square| 
        # Get whether the square is bomb adjacent and the squares that it is adjacent to.
        is_adjacent, squares = is_bomb_adjacent?(square)
        
        # Assigns the square as `BombAdjacent` with the squares that it is adjacent to 
        # if it is adjacent to a bomb.
        if is_adjacent
          grid[square.y][square.x] = BombAdjacent.new(square.x, square.y, squares)
        end
      end 
    end
  end

  # Checks to see if there's any bombs adjacent to the 
  # passed square.
  def is_bomb_adjacent?(square)
    # Return false if the passed square is a bomb.
    return false if square.is_a?(Bomb)

    # Get all squares around the passed square that exist
    # inside the grid.
    arr = [
      [square.y, square.x - 1], 
      [square.y - 1, square.x - 1],
      [square.y - 1, square.x], 
      [square.y - 1, square.x + 1],
      [square.y, square.x + 1],
      [square.y + 1, square.x + 1],
      [square.y + 1, square.x],
      [square.y + 1, square.x - 1]
    ].select{ |x,y| x >= 0 && y >= 0 && x < @width && y < @height}

    # Loop through reach square.
    arr.each do |coord|
      # Return true if the square is a `Bomb`.
      if grid[coord[0]][coord[1]].is_a?(Bomb)
        return true, squares(arr)
      end 
    end

    # Return false if we have not returned yet.
    return false
  end
  # Gets the squares from the grid for each coordinate in the passed array.

  def squares(arr)
    # Initialize an empty array.
    squares_arr = []

    # Loops through the coordinates array.
    arr.each do |coord|
      # Adds the sqaure from the grid that matches the coordinates to the squares 
      # array.
      squares_arr << grid[coord[0]][coord[1]]
    end

    # Returns the squares array.
    squares_arr
  end

  # This prints a message saying how many bombs there are left to place.
  def flags_left_message
    puts "There are #{@flag_count} flags left to place."
  end

  # This sets cheat mode to true.
  def set_cheat_mode
    @cheat_mode = true
  end
end


RSpec.describe Grid do 
  it 'should create a grid' do
    expect(Grid.new(3,3).create_grid.length).to eq(3)
    expect(Grid.new(3,3).create_grid[0].length).to eq(3)
  end

  it 'should assign the grid on initialization' do
    expect(Grid.new(3,3).grid.length).to eq(3)
    expect(Grid.new(3,3).grid[0].length).to eq(3)
  end

  it 'should assign the correct number of bombs' do
    grid = Grid.new(3, 3, 3).grid

    bomb_count = 0

    grid.each do |row|
      row.each do |col|
        if col.is_a?(Bomb)
          bomb_count += 1
        end
      end
    end

    expect(bomb_count).to eq(3)
  end

  it 'should draw the grid' do
    grid = Grid.new(3, 3, 3)

    expect do 
      grid.draw_grid
    end.to output("O | O | O\nO | O | O\nO | O | O\n").to_stdout
  end
end
