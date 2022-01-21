require 'rspec'
require_relative 'square'
require_relative 'bomb'

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

    place_bombs
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
      next if @grid[rand_x][rand_y].is_a?(Bomb)

      # Set the randomly selected grid x,y location as a bomb.
      @grid[rand_x][rand_y] = Bomb.new(rand_x, rand_y)

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
      puts row.map{ |x| x.draw }.join(' | ')
    end
  end

  def select(x, y)
    grid[x.to_i - 1][y.to_i - 1].set_clicked

    grid[x.to_i - 1][y.to_i - 1].is_a?(Bomb) ? true : false
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
