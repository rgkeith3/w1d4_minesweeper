require_relative 'board.rb'


class Minesweeper
  attr_accessor :over

  def initialize
    @board = Board.new
    @over = false
    @won = false
  end

  def run
    play_turn until @over || @won
  end



  def play_turn
    @board.display
    puts "Would you like to guess or flag?"
    input = gets.chomp
    pos = ask_pos

    case input.downcase

    when  "flag"
      flag(pos)
    when "guess"
      guess(pos)
    else
      puts "what?"
      play_turn
    end
  end

  def flag(pos)
    @board[pos].flag = true
  end


  def guess(pos)
    if @board[pos].bomb
      game_over
      reveal(pos)
      @board.display
    else
      reveal(pos)
    end
  end

  def reveal(pos)
    @board[pos].revealed = true
  end


  def parse(string)
    string.split(',').map { |el| Integer(el) }
  end

  def ask_pos
    puts "Enter position"
    parse(gets.chomp)
  end

  def game_over
    puts "Game over"
  end


end


game = Minesweeper.new
game.run
