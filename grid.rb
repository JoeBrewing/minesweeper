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

  def place_bombs
    # Initialize the number of placed bombs to 0.
    placed_bombs = 0

    while placed_bombs < @num_bombs
      rand_x = rand(@width)

      rand_y = rand(@height)

      next if @grid[rand_x][rand_y].is_a?(Bomb)

      @grid[rand_x][rand_y] = Bomb.new(rand_x, rand_y)

      placed_bombs += 1
    end
  end

  # Exposes the grid instance variable.
  def grid
    @grid
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
end
