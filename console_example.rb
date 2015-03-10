require 'io/console'
require_relative 'game'
user_input  = nil
should_exit = false
CTRL_C = "\u0003"
RED    = "\e[41m"
GREEN  = "\e[42m"
WHITE  = "\e[47m"
BLACK  = "\e[40m"
DEFAULT_COLOR = "\e[49m"

print "\e[2J"

game = Game.new

output = Thread.new do
  until should_exit
    sleep 0.25
    print "\e[1;1H"

    game.play(user_input)

    # user_input = nil
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
