require_relative 'tile.rb'


class Board

  def initialize
    @grid = Array.new(9) { Array.new(9) { Tile.new } }
    @bombs = []
    populate
  end

  def valid_pos?(pos)
    pos.all? { |el| el.between?(0, 8) }
  end

  def populate
    until @bombs.count == 9 do
      pos = [(0..8).to_a.sample, (0..8).to_a.sample]
      unless self[pos].bomb
        self[pos].bomb = true
        @bombs << self[pos]
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def display
    @grid.each do |row|
      row.each do |tile|
        print " "
        if tile.revealed
          if tile.bomb
            print "B "
          else
            print "_ "
          end
        else
          print "* "
        end
      end
      print "\n"
    end
  end

end
