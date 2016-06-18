require './disc'

class Board

  SIZE = 8

  attr_reader :map

  def initialize
    @map = Array.new(8) {|idx| Array.new(8) }
    @map[3][3] = Disc::WHITE
    @map[4][4] = Disc::WHITE
    @map[3][4] = Disc::BLACK
    @map[4][3] = Disc::BLACK
  end

  def put_disc(x, y, color)
    return nil unless can_put_disc?(x, y, color)
    @map[y][x] = color
    reverse_discs(x, y, color)
  end

  def can_put_disc?(x, y, color)
    @map[y][x] == nil && can_reverse_discs(x, y, color) != 0
  end

  def can_reverse_discs(x, y, color)
    can_reverse_left_discs(x, y, color) \
      + can_reverse_top_left_discs(x, y, color) \
      + can_reverse_top_discs(x, y, color) \
      + can_reverse_top_right_discs(x, y, color) \
      + can_reverse_right_discs(x, y, color) \
      + can_reverse_bottom_right_discs(x, y, color) \
      + can_reverse_bottom_discs(x, y, color) \
      + can_reverse_bottom_left_discs(x, y, color) \
  end

  def reverse_discs(x, y, color)
    reverse_left_discs(x, y, color) \
      + reverse_top_left_discs(x, y, color) \
      + reverse_top_discs(x, y, color) \
      + reverse_top_right_discs(x, y, color) \
      + reverse_right_discs(x, y, color) \
      + reverse_bottom_right_discs(x, y, color) \
      + reverse_bottom_discs(x, y, color) \
      + reverse_bottom_left_discs(x, y, color) \
  end

  private
  def can_reverse_left_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    discs = (1..x).inject(0) { |sum , n|
      break sum unless @map[y][x - n] == other_color
      sum + 1
    }
    return 0 if discs == x || @map[y][x - discs - 1] != color
    discs
  end

  def can_reverse_top_left_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    min = [x, y].min
    discs = (1..min).inject(0) { |sum, n|
      break sum unless @map[y - n][x - n] == other_color
      sum + 1
    }
    return 0 if discs == min || @map[y - discs - 1][x - discs - 1] != color
    discs
  end

  def can_reverse_top_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    discs = (1..y).inject(0) { |sum , n|
      break sum unless @map[y - n][x] == other_color
      sum + 1
    }
    return 0 if discs ==  y || @map[y - discs - 1][x] != color
    discs
  end

  def can_reverse_top_right_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    min = [(SIZE - x - 1), y].min
    discs = (1..min).inject(0) { |sum, n|
      break sum unless @map[y - n][x + n] == other_color
      sum + 1
    }
    return 0 if discs == min || @map[y - discs - 1][x + discs + 1] != color
    discs
  end

  def can_reverse_right_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    discs = (1..x).inject(0) { |sum , n|
      break sum unless @map[y][x + n] == other_color
      sum + 1
    }
    return 0 if discs == SIZE - x - 1 || @map[y][x + discs + 1] != color
    discs
  end

  def can_reverse_bottom_right_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    min = [(SIZE - x - 1), (SIZE - y - 1)].min
    discs = (1..min).inject(0) { |sum, n|
      break sum unless @map[y + n][x + n] == other_color
      sum + 1
    }
    return 0 if discs == min || @map[y + discs + 1][x + discs + 1] != color
    discs
  end

  def can_reverse_bottom_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    discs = (1..y).inject(0) { |sum , n|
      break sum unless @map[y + n][x] == other_color
      sum + 1
    }
    return 0 if discs == SIZE - y - 1 || @map[y + discs + 1][x] != color
    discs
  end

  def can_reverse_bottom_left_discs(x, y, color)
    other_color = (color == Disc::BLACK ? Disc::WHITE : Disc::BLACK)
    min = [x, (SIZE - y - 1)].min
    discs = (1..min).inject(0) { |sum, n|
      break sum unless @map[y + n][x - n] == other_color
      sum + 1
    }
    return 0 if discs == min || @map[y + discs + 1][x - discs - 1] != color
    discs
  end

  def reverse_left_discs(x, y, color)
    can_reverse_discs = can_reverse_left_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y][x - n] = color }
    can_reverse_discs
  end

  def reverse_top_left_discs(x, y, color)
    can_reverse_discs = can_reverse_top_left_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y - n][x - n] = color }
    can_reverse_discs
  end

  def reverse_top_discs(x, y, color)
    can_reverse_discs = can_reverse_top_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y - n][x] = color }
    can_reverse_discs
  end

  def reverse_top_right_discs(x, y, color)
    can_reverse_discs = can_reverse_top_right_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y - n][x + n] = color }
    can_reverse_discs
  end

  def reverse_right_discs(x, y, color)
    can_reverse_discs = can_reverse_right_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y][x + n] = color }
    can_reverse_discs
  end

  def reverse_bottom_right_discs(x, y, color)
    can_reverse_discs = can_reverse_bottom_right_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y + n][x + n] = color }
    can_reverse_discs

  end

  def reverse_bottom_discs(x, y, color)
    can_reverse_discs = can_reverse_bottom_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y + n][x] = color }
    can_reverse_discs
  end

  def reverse_bottom_left_discs(x, y, color)
    can_reverse_discs = can_reverse_bottom_left_discs(x, y, color)
    (1..can_reverse_discs).each { |n| @map[y + n][x - 1] = color }
    can_reverse_discs
  end

end
