require_relative 'tile'
require 'byebug'
require 'colorize'

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
    (0...grid.length).each { |num| row_nums << " #{num} " }
    puts row_nums

    grid.each_with_index { |row, idx| display_row(row, idx) }
  end

  def display_row(row, idx)
    row_string = "#{idx} "
    row.each do |tile|
      if tile.flagged
        row_string << "[f]".colorize(:green)
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
    until bomb_count == grid.length
      pos = [rand(grid.length - 1), rand(grid.length - 1)]
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
    bomb_positions = grid.flatten.select { |tile| tile.is_a_bomb }
    not_bomb_positions = grid.flatten.select { |tile| !tile.is_a_bomb }

    if (bomb_positions.all? {|tile| tile.flagged }) &&
    (not_bomb_positions.all? {|tile| !tile.flagged })
      Kernel.abort("Game over, you won!")
      true
    end

    false
  end
end
