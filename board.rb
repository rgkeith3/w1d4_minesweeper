require_relative 'tile.rb'


class Board

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    @bombs = []
    populate
  end

  def valid_pos?(pos)
    pos.all? { |el| el.between?(0, 8) }
  end

  def populate
    (0..8).each do |row|
      (0..8).each do |col|
        pos = [row,col]
        self[pos] = Tile.new(pos, self)
      end
    end
    add_bombs
  end

  def add_bombs
    until @bombs.count == 10 do
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

  def bombs_disp
    return "00" if flag_count > 9
    num = (10 - flag_count).to_s
    if num.length < 2
      "0" + num
    else
      num
    end
  end

  def flag_count
    @grid.flatten.count {|tile| tile.flag}
  end


  def display
    puts "____________________"
    puts "#{bombs_disp}   MINESWEEPER    "
    puts "____________________"
    puts " |0|1|2|3|4|5|6|7|8|"
    @grid.each_with_index do |row, row_id|
      print "#{row_id}|"
      row.each do |tile|
        if tile.revealed
          display_revealed(tile)
        elsif tile.flag
          print "F|"
        else
          print "*|"
        end
      end
      print "\n"
    end
  end

  def display_revealed(tile)
    if tile.bomb
      print "B|"
    elsif tile.count > 0
      print "#{tile.count}|"
    else
      print "_|"
    end
  end

  def get_neighbors(pos)
    neighbors = []
    (-1..1).each do |i|
      (-1..1).each do |j|
        neighbors << [pos[0] + j, pos[1] + i]
      end
    end
    neighbors.delete(pos)
    neighbors
  end

  def bomb_neighbors(pos)
    count = 0
    get_neighbors(pos).each do |el|
      count += 1 if self[el].bomb
    end
    self[pos].count = count
  end

end
