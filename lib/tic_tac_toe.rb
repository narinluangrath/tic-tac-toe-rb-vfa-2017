# The smart thing to do would be to use require, but I'd fail the test for #draw?

#require "~/code/ttt-game-status-vfa-2017/lib/game_status.rb"
#require "~/code/ttt-10-current-player-vfa-2017/lib/current_player.rb"
#require "~/code/ttt-9-play-loop-vfa-2017/lib/play.rb"

##### From play.rb

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#### From current_player.rb

def turn_count(board)
  counter = 0
  board.each do |e|
    if (e == "X" or e == "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  return (turn_count(board) % 2) == 0 ? "X" : "O"
end

#### From game_status.rb

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    combo.all?{ |index| board[index] == "X" } ||
    combo.all?{ |index| board[index] == "O" }
  end
end

def full?(board)
  return board.none?{ |e| e == " " || e == "" || e == nil}
end

def draw?(board)
  f = full?(board)
  w = won?(board)
  return f && !w
end

def over?(board)
  return won?(board) || full?(board)
end

def winner(board)
  w = won?(board)
  return w ? board[w[0]] : w
end

def play(board)
  until over?(board) do
    turn(board)
  end
  draw?(board) ? (puts "Cats Game!") : (puts "Congratulations #{winner(board)}!")
end

# def play(board)
#   while !over?(board)
#     turn(board)
#   end
#   if won?(board)
#     puts "Congratulations #{winner(board)}!"
#   elsif draw?(board)
#     puts "Cats Game!"
#   end
# end
