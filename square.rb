require 'rspec'

class Square
  # A class to hold information for each square. Each grid square will be this 
  # class when the grid is generated. Each square will still be this if they 
  # are not a `Bomb` or `BombAdjacent`.

  # Initialize the location of the `Square`.
  def initialize(x, y)
    @x = x

    @y = y

    @clicked = false
  end

  # Expose the x location.
  def x
    @x
  end

  # Expose the y location.
  def y
    @y
  end

  # Expose whether or not the square has been clicked.
  def clicked 
    @clicked
  end

  # Draw the square as part of the grid.
  def draw
    if clicked
      'C'
    else
      'O'
    end
  end

  # Exposes the clicked instance variable to be set to true.
  def set_clicked
    @clicked = true
  end
end

RSpec.describe Square do
  it 'should assign x and y values' do
    expect(Square.new(2,2).x).to eq(2)
    expect(Square.new(2,2).y).to eq(2)
    expect(Square.new(2,2).clicked).to eq(false)
  end
end