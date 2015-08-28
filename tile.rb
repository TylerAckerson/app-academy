require 'byebug'

class Tile
  attr_reader   :revealed, :location
  attr_accessor :flagged, :is_a_bomb, :board

  def initialize(location, board)
    @board = board
    @is_a_bomb = false
    @revealed = false
    @flagged = false
    @location = location 
  end

  def reveal
    @revealed = true
  end

  def toggle_flag
    flagged = flagged ? false : true
  end

  def neighbors
    cur_x, cur_y = location
    neighbors = []

    3.times do |x|
      3.times do |y|
        neighbor_pos = [cur_x - x + 1, cur_y - y + 1]
        next if neighbor_pos == location
        if neighbor_pos.all? { |coord| (0..8).include?(coord) }
          neighbors << neighbor_pos
        end
      end
    end

    neighbors
  end

  def neighbor_bomb_count
    neighbors.count {|pos| board[pos].is_a_bomb}
  end
end
