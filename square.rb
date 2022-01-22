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

    @flagged = false
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
    if @flagged
      'F'
    elsif clicked
      'C'
    else
      'O'
    end
  end

  # Sets clicked to true and returns lost as false.
  def set_clicked
    @clicked = true

    false
  end

  # Sets flagged to the opposite of what it currently is.
  def set_flagged
    @flagged = !@flagged

    # Return flag so it can be determined whether to add or subtract a 
    # flag from the flag count.
    @flagged
  end
end

RSpec.describe Square do
  it 'should assign x and y values' do
    expect(Square.new(2,2).x).to eq(2)
    expect(Square.new(2,2).y).to eq(2)
    expect(Square.new(2,2).clicked).to eq(false)
  end

  it 'should set clicked' do 
    square = Square.new(1,1)

    square.set_clicked

    expect(square.clicked).to eq(true)
  end

  it 'should return false for lost' do
    square = Square.new(1,1)

    expect(square.set_clicked).to eq(false)
  end

  it 'draw should return O if not clicked' do
    expect(Square.new(1,1).draw).to eq('O')
  end

  it 'draw should return C if not clicked' do
    square = Square.new(1,1)

    square.set_clicked
    
    expect(square.draw).to eq('C')
  end
end