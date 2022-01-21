require_relative('grid')

class Game 
  def initialize
    play
  end

  def play
    height = get_value('Input the grid height: ')
    width = get_value('Input the grid width: ')
    bomb_count = get_value('Input the number of bombs: ')

    grid = Grid.new(height, width, bomb_count)

    grid.draw_grid
  end

  def get_value(prompt)
    puts prompt
    height = gets.chomp.to_i
  end
end

Game.new

