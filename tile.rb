require 'byebug'

class Tile
  attr_reader   :revealed, :location
  attr_accessor :flagged, :is_a_bomb

  def initialize(location) #should board be in here?
    # @board = board
    @is_a_bomb = false
    @revealed = false
    @flagged = false
    @location = location #come back to this
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
        # debugger
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

  end
end
