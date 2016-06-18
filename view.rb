class View

  def initialize(board)
    @board = board
    @viewer = BoardViewer.new(@board)
  end

  def render(tern_color)
    clear
    @viewer.show
    puts (tern_color == Disc::BLACK ? "BLACK" : "WHITE") + " TURN."
  end

  private
  def clear
    print "\e[0;0H\e[0J"
  end

end
