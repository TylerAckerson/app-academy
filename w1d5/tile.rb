require 'byebug'
require 'colorize'

class Tile
  attr_reader :location
  attr_accessor :flagged, :is_a_bomb, :board, :revealed

  def initialize(location, board)
    @board = board
    @is_a_bomb = false
    @revealed = false
    @flagged = false
    @location = location
  end

  def inspect
    "location: #{location} \n is_a_bomb: #{is_a_bomb} \n neighbor_bombs: #{neighbor_bombs}"
  end

  def render
    if is_a_bomb
      "[!]".colorize(:red)
    elsif neighbor_bombs.length == 0
      "[ ]"
    else

      color = case neighbor_bombs.length
      when 2
        :green
      when 1
        :blue
      else
        :red
      end

      "[#{neighbor_bombs.length}]".colorize(color)
    end
  end

  def reveal
    return if revealed
    self.revealed = true

    return unless neighbor_bombs.empty?

    neighbors.each do |pos|
      board[pos].reveal
    end
  end

  def toggle_flag
    self.flagged = flagged ? false : true
  end

  def neighbors
    cur_x, cur_y = location
    neighbors = []

    3.times do |x|
      3.times do |y|
        neighbor_pos = [cur_x - x + 1, cur_y - y + 1]
        next if neighbor_pos == location
        if neighbor_pos.all? { |coord| (0...board.grid.length).include?(coord) }
          neighbors << neighbor_pos
        end
      end
    end

    neighbors
  end

  def neighbor_bombs
    neighbors.select {|pos| board[pos].is_a_bomb}
  end
end
