require_relative 'tile'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize(size = 9)
    @grid = Array.new(size) { Array.new(size) }
    populate_grid
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def display
    system('clear')

    row_nums = "  "
    (0..8).each { |num| row_nums << " #{num} " }
    puts row_nums

    grid.each_with_index { |row, idx| display_row(row, idx) }

    sleep(1)
  end

  def display_row(row, idx)
    row_string = "#{idx} "
    row.each do |tile|
      if tile.flagged
        row_string << "[f]"
      elsif tile.revealed
        row_string << tile.render
      elsif tile.flagged

      else
        row_string << "[O]"
      end
    end
    puts row_string
  end

  def populate_grid
      place_tiles
      place_bombs
      calculate_neighbor_bombs
  end

  def place_tiles
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        self[[row_idx, col_idx]] = Tile.new([row_idx, col_idx], self)
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

  def calculate_neighbor_bombs
    grid.flatten.each { |tile| tile.neighbor_bombs }
  end

  def over?

  end

end

if __FILE__ == $PROGRAM_NAME
  m = Board.new
  m.display

end
