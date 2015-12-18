require 'pry'
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_CHOICES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
def prompt(message)
  puts "=> #{message}"
end

def display_board(brd)
  system 'clear'
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end

def display_scores(player_score, computer_score)
  prompt("player score    |   computer score")
  prompt("<-------------------------------->")
  prompt("        #{player_score}              #{computer_score}")
end

def joinor(arr, delimiter = ',', word = 'or')
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.join(delimiter)
end

def empty_spaces(brd)
  brd.keys.select { |num| brd[num] == ' ' }
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' ' }
  new_board
end

def player_plays(brd)
  player_choice = ''
  loop do
    prompt "select your choice #{joinor(empty_spaces(brd))}"
    player_choice = gets.chomp.to_i
    break if empty_spaces(brd).include?(player_choice)
    prompt("That's not a valid choice")
  end
  brd[player_choice] = 'X'
end

def computer_plays(brd)
  computer_choice = nil
  WINNING_CHOICES.each do |group|
    if brd.values_at(*group).count(PLAYER_MARKER) == 2
      computer_choice = brd.select { |key,value| group.include?(key) && value == ' ' }.keys.first
      break if computer_choice
    end
  end
  WINNING_CHOICES.each do |group|
    if brd.values_at(*group).count(COMPUTER_MARKER) == 2
      computer_choice = brd.select { |key,value| group.include?(key) && value == ' ' }.keys.first
      break if computer_choice
    end
  end
  if !computer_choice
    computer_choice = empty_spaces(brd).sample
  end
  brd[computer_choice] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_spaces(brd).empty?
end

def someone_wins?(brd)
  !!find_winner(brd)
end

def find_winner(brd)
  WINNING_CHOICES.each do |group|
    if brd.values_at(group[0], group[1], group[2]).count(PLAYER_MARKER) == 3
      return 'player'
    elsif brd.values_at(group[0], group[1], group[2]).count(COMPUTER_MARKER) == 3
      return 'computer'
    end
    # if brd[group[0]] == PLAYER_MARKER && brd[group[1]] == PLAYER_MARKER && brd[group[2]] == PLAYER_MARKER
    #    return 'player'
    # elsif brd[group[0]] == COMPUTER_MARKER &&
    #        brd[group[1]] == COMPUTER_MARKER &&
    #      brd[group[2]] == COMPUTER_MARKER
    #    return 'computer'
    # end
  end
  nil
end

loop do
  player_score||= 0
  computer_score||= 0
  loop do
    board = initialize_board
    loop do
      display_board(board)
      display_scores(player_score, computer_score)
      player_plays(board)
      break if someone_wins?(board) || board_full?(board)
      computer_plays(board)
      break if someone_wins?(board) || board_full?(board)
    end
    display_board(board)
    if someone_wins?(board)
      prompt "#{find_winner(board)} wins"
      if "#{find_winner(board)}" == 'player'
        player_score += 1
      elsif"#{find_winner(board)}" == 'computer'
        computer_score += 1
      end
      else
      prompt " It's a tie "
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
    prompt "Do you want to play again (press Y to continue)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
  break
end

prompt "Thanks for playing TicTacToe!"
