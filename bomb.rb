require 'rspec'
require_relative 'square'

class Bomb < Square
  # This class handles functionality related to whether or not a square is a bomb.
  def initialize(x, y)
    super
  end

  # Draw the bomb as part of the grid. Will be 'X' if clicked, otherwise it will be 'O'.
  def draw
    if clicked
      'X'
    else   
      'O'
    end
  end
end