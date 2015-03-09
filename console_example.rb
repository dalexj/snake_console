require 'io/console'
user_input  = nil
game_board = Array.new(20) { Array.new(20) { " " } }
should_exit = false
location = [5, 5]
CTRL_C = "\u0003"
RED    = "\e[41m"
GREEN  = "\e[42m"
WHITE  = "\e[47m"
DEFAULT_COLOR = "\e[49m"
UP_ARROW    = "\e[A"
DOWN_ARROW  = "\e[B"
RIGHT_ARROW = "\e[C"
LEFT_ARROW  = "\e[D"

def pputs(arg)
  print "\e[2K"
  print arg
  print "\n\e[1G"
end

print "\e[2J"

def play(input, board, loc)
  if input == UP_ARROW
    loc[0] -= 1
  elsif input == DOWN_ARROW
    loc[0] += 1
  elsif input == LEFT_ARROW
    loc[1] -= 1
  elsif input == RIGHT_ARROW
    loc[1] += 1
  end
  board = Array.new(20) { Array.new(20) { " " } }
  board[1][1] = GREEN + " "
  board[loc[0]][loc[1]] = WHITE + " "
  board.each do |line|
    pputs RED + line.join(" " + RED) + DEFAULT_COLOR
  end
end

output = Thread.new do
  until should_exit
    sleep 0.5
    print "\e[1;1H"

    pputs user_input.inspect
    play(user_input, game_board, location)

    user_input = nil
    # print "\e[1;1H"
  end
end

until should_exit
  user_input = STDIN.getch
  if user_input == "\e"
    user_input += STDIN.getch
    user_input += STDIN.getch
  end
  raise "" if user_input == CTRL_C
end

output.join
