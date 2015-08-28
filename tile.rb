require 'byebug'

class Tile
  attr_reader   :revealed, :location
  attr_accessor :flagged, :is_a_bomb, :board, :neighbor_bombs

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
      "[!]"
    elsif neighbor_bombs.length == 0
      "[ ]"
    else
      "[#{neighbor_bombs.length}]"
    end
  end

  def reveal
    @revealed = true
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
    self.neighbor_bombs = neighbors.select {|pos| board[pos].is_a_bomb}
  end
end
