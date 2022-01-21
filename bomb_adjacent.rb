require 'rspec'
require_relative 'square'

class BombAdjacent < Square
  # This class handles functionality related to squares that are bomb adjacent.
  
  # Initialize the bomb object by just calling the super class initialize.
  def initialize(x, y)
    super(x, y)
  end

  # Draw the bomb adjacent as part of the grid. Will be 'B' if clicked
  # otherwise it will be 'O'.
  def draw 
    if clicked
      'B'
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