UP_ARROW    = "\e[A"
DOWN_ARROW  = "\e[B"
RIGHT_ARROW = "\e[C"
LEFT_ARROW  = "\e[D"

class Game
  def initialize
    @locs = [[5,5], [4,5], [3,5], [3,4], [3,3], [2,3], [1,3]]
    @direction_headed = LEFT_ARROW
  end

  def pputs(arg)
    print "\e[2K"
    print arg
    print "\n\e[1G"
  end

  def direction?(direction)
    [UP_ARROW, DOWN_ARROW, RIGHT_ARROW, LEFT_ARROW].include? direction
  end

  def play(input)
    @direction_headed = input if direction? input
    if @direction_headed == UP_ARROW
      move_up
    elsif @direction_headed == DOWN_ARROW
      move_down
    elsif @direction_headed == LEFT_ARROW
      move_left
    elsif @direction_headed == RIGHT_ARROW
      move_right
    end
    board = Array.new(20) { Array.new(20) { " " } }
    board[1][1] = GREEN + " "
    @locs.each_with_index do |loc, index|
      if index == 0
        board[loc[0]][loc[1]] = BLACK + " "
      else
        board[loc[0]][loc[1]] = WHITE + " "
      end
    end
    board.each do |line|
      pputs RED + line.join(" " + RED) + DEFAULT_COLOR
    end
  end

  def shift_squares
    @locs.pop
    @locs.unshift(@locs.first.dup)
  end

  def move_up
    shift_squares
    @locs[0][0] -= 1
  end

  def move_down
    shift_squares
    @locs[0][0] += 1
  end

  def move_left
    shift_squares
    @locs[0][1] -= 1
  end

  def move_right
    shift_squares
    @locs[0][1] += 1
  end
end
