require './disc'
require './board'

class BoardViewer

  WHITE_DISC = "○"
  BLACK_DISC = "●"
  BLANK      = "  "

  def initialize(board)
    @board = board
  end

  def show
    puts "    A   B   C   D   E   F   G   H"
    puts "  ┼─┼─┼─┼─┼─┼─┼─┼─┼"

    @board.map.each.with_index(1) do |row, index|
      print " #{index}│"
      row.each do |cell|
        print "#{show_cell(cell)}│"
      end
      print "\n"
      puts "  ┼─┼─┼─┼─┼─┼─┼─┼─┼"
    end
  end
  
  private
  def show_cell(cell)
    return WHITE_DISC if cell == Disc::WHITE
    return BLACK_DISC if cell == Disc::BLACK
    BLANK
  end

end

#    A   B   C   D   E   F   G   H
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 1│  │  │  │  │  │  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 2│  │  │  │  │  │  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 3│  │  │  │  │  │  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 4│  │  │  │○│●│  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 5│  │  │  │●│○│  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 6│  │  │  │  │  │  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 7│  │  │  │  │  │  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
# 8│  │  │  │  │  │  │  │  │
#  ┼─┼─┼─┼─┼─┼─┼─┼─┼
#
