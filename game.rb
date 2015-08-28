require_relative 'board'
require_relative 'tile'

class Game
  attr_reader :board, :player_move, :player_opt

  def initialize(size = 9)
    @board = Board.new(size)
  end

  def play
    board.display

    while true
      get_move
      evaluate_move
      board.display
    end
    #until board.over?
      #player interaction
        #ask for a move
        # if that move is a bomb you lost

    #end

    #you lost

    #||

    #you won!

  end

  def evaluate_move
    if player_opt.downcase == "flag"
      puts board[player_move]
      puts board[player_move].flagged

      board[player_move].toggle_flag
      puts board[player_move].flagged

    elsif player_opt.downcase == "select"
      board[player_move].reveal
      if board[player_move].is_a_bomb
        puts "There's a bomb there, you idiot! You lose!"
      end

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
  game = Game.new
  game.play
end
