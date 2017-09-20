class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [2,5,8],
    [1,4,7]
  ]
  def display_board(board = nil)
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def input_to_index(user_input)
    board_index_num = user_input.to_i - 1
  end
  def move(input_to_index, player = "X")
    @board[input_to_index] = player
  end
  def position_taken?(board = nil, input_to_index)
    if @board[input_to_index] == "X" || @board[input_to_index] == "O"
      return true
    else
      return false
    end
  end
  def valid_move?(board = nil, input_to_index)
    if position_taken?(@board, input_to_index) == false && input_to_index.between?(0,8) == true
      return true
    else
      return false
    end
  end
  def turn_count(board = nil)
    @board.count {|i| i == "X" || i == "O"}
  end
  def current_player(board = nil)
    turn_count(@board) % 2 == 0 ? "X" : "O"
  end
  def turn(board = nil)
    puts "Please Enter 1-9"
      index = gets.strip
      position = input_to_index(index)
      valid = valid_move?(@board,position)
      current = current_player(@board)
      if valid == true
        move(position, current)
        display_board(@board)
      else
        turn(@board)
      end
  end
  def won?(board = nil)
    i = 0
    check = []
    while i < 8
    WIN_COMBINATIONS[i].each do |num|
      check << @board[num]
    end
     if check.all?{|x| x == "X"} == true || check.all?{|x| x == "O"} == true
      return WIN_COMBINATIONS[i]
     end
      i += 1
      check = [ ]
    end
  end
  def full?(board = nil)
      if @board.any?{|i| i == " "} == true || @board.any?{|i| i == ""} == true
        return false
      else
        return true
    end
  end
  def draw?(board = nil)
    if won?(@board) == nil && full?(@board) == true
      return true
    else
      return false
    end
  end
  def over?(board = nil)
    if won?(@board) != nil || full?(@board) == true
      return true
    else
      return false
    end
  end
  def winner(board = nil)
    if over?(@board) == true || won?(@board) != nil
      return @board[won?(@board)[0]]
    end
  end
  def play(board = nil)
    until over?(@board) == true
      turn(@board)
      if draw?(@board) == true
        break
      end
    end
    if won?(@board)
      puts "Congratulations #{winner(@board)}!"
    elsif draw?(@board)
      puts "Cat's Game!"
    end
  end
end
