require 'rspec'
require_relative 'square'

class Bomb < Square
  # This class handles functionality related to bombs.
  
  # Initialize the bomb object by just calling the super class initialize.
  def initialize(x, y)
    super(x, y)
  end

  # Draw the bomb as part of the grid. Will be 'X' if clicked, otherwise it will be 'O'.
  def draw(cheat)
    if cheat && !@flagged && !clicked
      return 'B'
    end

    if @flagged
      'F'
    elsif clicked
      'X'
    else   
      'O'
    end
  end

  # Sets clicked to true and returns lost as true.
  def set_clicked
    @clicked = true

    true
  end
end

RSpec.describe Bomb do
  it 'should return true for lost' do
    expect(Bomb.new(1,1).set_clicked).to eq(true)
  end

  it 'draw should return O if not clicked' do
    expect(Bomb.new(1,1).draw(false)).to eq('O')
  end

  it 'draw should return X if not clicked' do
    bomb = Bomb.new(1,1)

    bomb.set_clicked
    
    expect(bomb.draw(false)).to eq('X')
  end
end