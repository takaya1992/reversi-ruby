require './disc'
require './board'
require './board_viewer'
require './view'


board = Board.new
view = View.new(board)

(0..10).each do |n|
  tern_color = (n % 2 == 0) ? Disc::BLACK : Disc::WHITE
  view.render(tern_color)
  point_input = ""
  loop do
    loop do
      print ">> "
      point_input = $stdin.gets.chomp
      break if point_input =~ /^[A-H][1-8]+$/
      puts "正しい書式(ex: E2)で座標を入力してください"
    end
    point = point_input.split("")
    x = point[0].ord - "A".ord
    y = point[1].to_i - 1
    if board.can_put_disc?(x, y, tern_color)
      board.put_disc(x, y, tern_color)
      break
    else
      puts "そこには置けません (#{point_input})"
    end
  end
end
