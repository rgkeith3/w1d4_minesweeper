require_relative 'board.rb'


class Minesweeper
  def initialize
    @board = Board.new
    # run
  end

  def run
    play_turn until game_over || won?
  end

  def play_turn
    pos = ask_pos
    if @board[pos].bomb
      game_over
    else
      reveal(pos)
    end
  end

  def reveal(pos)
    @board[pos].revealed = true
    @board.display
  end


  def parse(string)
    string.split(',').map { |el| Integer(el) }
  end

  def ask_pos
    puts "Enter position to reveal"
    parse(gets.chomp)
  end

  def game_over
    puts "Game over"
  end


end
