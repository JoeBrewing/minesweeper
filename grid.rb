require 'rspec'

class Grid
  def initialize(height, width)
    @height = height

    @width = width

    @grid = create_grid
  end

  def create_grid
    arr = []
    
    @height.times do |y|
      arr[y] = [] 
      
      @width.times do |x|
        arr[y] << 'placeholder'
      end
    end

    arr
  end

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
end
