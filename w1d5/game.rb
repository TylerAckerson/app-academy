require_relative 'board'
require_relative 'tile'

class Game
  attr_reader :board, :player_move, :player_opt

  def initialize(size = 9)
    @board = Board.new(size)
  end

  def play
    board.display

    until board.over?
      get_move

      if board[player_move].is_a_bomb && player_opt == 'select'
        board[player_move].reveal
        board.display
        Kernel.abort("You lose! Game over.")
        break
      else
        evaluate_move
      end

      board.display
    end
  end

  def evaluate_move
    if player_opt.downcase == "flag"
      board[player_move].toggle_flag
    elsif player_opt.downcase == "select"
      board[player_move].reveal
    else
      get_move
      evaluate_move
    end
  end

  def get_move
    puts "Please enter a move... eg. x,y"
    puts " >> "
    @player_move = gets.chomp.split(",").map(&:to_i)

    puts "Select position or flag?"
    puts " >> "
    @player_opt = gets.chomp
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new(9)
  game.play
end
