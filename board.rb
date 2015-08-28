require_relative 'tile.rb'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize(size = 9)
    @grid = Array.new(size) { Array.new(size) }
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def populate_grid
      place_tiles
      place_bombs
      #set_adjacent_numbers
  end

  def place_tiles
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        self[[row_idx, col_idx]] = Tile.new([row_idx, col_idx])
      end
    end
  end

  def place_bombs
    bomb_count = 0
    until bomb_count == 10
      pos = [rand(8), rand(8)]
      unless self[pos].is_a_bomb
        bomb = self[pos]
        bomb.is_a_bomb = true
        bomb_count += 1
      end
    end
  end

  def set_adjacent_numbers

  end

end
