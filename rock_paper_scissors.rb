
VALID_COMPUTER_CHOICES = %w(rock paper scissors lizard spock)
VALID_PLAYER_CHOICES = { "r" => "rock", "p" => "paper", "s" => "scissors", "l" => "lizard", "sp" => "spock" }
WINNER_CHOICES = { "rock" => %w(scissors spock),
                   "paper" => %w(rock lizard),
                   "scissors" => %w(paper spock),
                   "lizard" => %w(rock scissors),
                   "spock" => %w(paper lizard) }
def test_method
  prompt("test message")
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  WINNER_CHOICES[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("you won!")
  elsif win?(computer, player)
    prompt("computer won!")
  else
    prompt("It's a tie")
  end
end

def display_scores(player_score, computer_score)
  prompt("player score    |   computer score")
  prompt("<-------------------------------->")
  prompt("        #{player_score}              #{computer_score}")
end

player_choice = ''
player_score = 0
computer_score = 0
loop do # main loop
  loop do # validating the selected player choice
    prompt("choose one abbrevated choice:rock(r),paper(p),scissors(s),lizard(l),spok(sp)")
    player_choice = Kernel.gets().chomp
    if VALID_PLAYER_CHOICES.keys.include?(player_choice)
      player_choice = VALID_PLAYER_CHOICES[player_choice]
      break
    else
      prompt("That is not a valid choice")
    end
  end
  computer_choice = VALID_COMPUTER_CHOICES.sample()
  prompt("your choice #{player_choice} and computer choice #{computer_choice}")
  if win?(player_choice, computer_choice)
    prompt("you won!")
    player_score += 1
  elsif win?(computer_choice, player_choice)
    prompt("computer won!")
    computer_score += 1
  else
    prompt("It's a tie")
  end
  if player_score == 5
    prompt("Player got #{player_score} points first and won the game!!")
    display_scores(player_score, computer_score)
    player_score = 0
    computer_score = 0
  elsif computer_score == 5
    prompt("Computer got #{computer_score} points first and won the game!!")
    display_scores(player_score, computer_score)
    computer_score = 0
    player_score = 0
  else
    display_scores(player_score, computer_score)
  end
  prompt("Do you want to play again?(Press Y to continue)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt("Thank you for playing .Good bye!")
