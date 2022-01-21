require 'rspec'
require_relative 'square'
require_relative 'bomb'

class BombAdjacent < Square
  # This class handles functionality related to squares that are bomb adjacent.
  
  # Initialize the bomb object by just calling the super class initialize.
  def initialize(x, y, adjacent_squares)
    @adjacent_squares = adjacent_squares

    super(x, y)
  end

  # Draw the bomb adjacent as part of the grid. Will be 'B' if clicked
  # otherwise it will be 'O'.
  def draw 
    if clicked
      @adjacent_squares.select{ |x| x.is_a?(Bomb) }.length
    else   
      'O'
    end
  end

  # Sets clicked to true and returns lost as true.
  def set_clicked
    @clicked = true

    false
  end
end