class Tile

  attr_accessor :bomb, :revealed, :count, :flag

  def initialize(pos, board)
    @bomb = false
    @revealed = false
    @flag = false
    @count = 0
    @pos = pos
    @board = board
  end






end
