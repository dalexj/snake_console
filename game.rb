UP_ARROW    = "\e[A"
DOWN_ARROW  = "\e[B"
RIGHT_ARROW = "\e[C"
LEFT_ARROW  = "\e[D"

class Game
  def initialize
    @locs = [[5,5], [4,5], [3,5], [3,4], [3,3], [2,3], [1,3]]
    @direction_headed = LEFT_ARROW
    @eating_thing = [1, 1]
  end

  def pputs(arg)
    print "\e[2K"
    print arg
    print "\n\e[1G"
  end

  def direction?(direction)
    direction =~ /\e\[[A-D]/
  end

  def play(input)
    move_snake(input)
    board = Array.new(20) { Array.new(20) { " " } }
    draw_eating_thing(board)
    draw_snake(board)
    print_board(board)
  end

  def draw_eating_thing(board)
    board[@eating_thing[0]][@eating_thing[1]] = GREEN + " "
  end

  def move_snake(input)
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
    check_for_eating_thing
  end

  def check_for_eating_thing
    if @locs[0] == @eating_thing
      @should_get_bigger = true
      make_new_eating_thing
    end
  end

  def make_new_eating_thing
    @eating_thing = @locs[0]
    while @locs.include? @eating_thing
      @eating_thing = [rand(20), rand(20)]
    end
  end

  def draw_snake(board)
    @locs.each_with_index do |loc, index|
      if index == 0
        board[loc[0]][loc[1]] = BLACK + " "
      else
        board[loc[0]][loc[1]] = WHITE + " "
      end
    end
  end

  def print_board(board)
    board.each do |line|
      pputs RED + line.join(" " + RED) + DEFAULT_COLOR
    end
  end

  def shift_squares
    if @should_get_bigger
      @should_get_bigger = false
    else
      @locs.pop
    end
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
