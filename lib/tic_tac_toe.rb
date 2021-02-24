require 'pry'
class TicTacToe
    WIN_COMBINATIONS= [
        [0,1,2], # Top row
        [3,4,5],  # Middle row
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6],
    ]

def initialize
    @board = Array.new(9, " ")
end

def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
 end

 def input_to_index(input)
    index = input.to_i - 1
 end

 def move(index, token= "X")
    # binding.pry
    # index = input_to_index(input) ---- the value has already been converted
    @board[index]= token
 end

 def position_taken?(index)
    if @board[index] == "X" || @board[index] == "O"
        true
    else
        false
    end
 end

 def valid_move?(index)
    if !position_taken?(index) && index >= 0 && index <= 8
        true
    end
 end


 def turn
    puts "Yo put something in"
    input= gets.strip
    index = input_to_index(input)
   player = current_player
    if valid_move?(index)
        move(index, player)
        display_board
    else
        turn
    end
 end


 def turn_count
    count = 0
    @board.each do |space|
        if space == "X" || space == "O"
            count +=1
        end
    end
    count
 end

 def current_player
    turn_count % 2 == 0 ? "X" : "O"
 end

def won?
     WIN_COMBINATIONS.each do|combo|
        if @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && @board[combo[0]] != " "
            #it checks the edge case & makes sure there's no empty spaces to return
            #@board[combo[0]] this is the actual spot of where x's and o's are, instead o getting numbers like winning combo const
            #these combo indexes check to see if the values inside the array are the same
           return combo #explicitly returns the combo, so it doesn't automatically default to the return val of false below.
        end
    end
     false
end


def full?
   (0..8).all? do |index| #i'm using an array of numbers bc position_taken only checks for integers. 
    #i wanted to do @board originally, but the spaces that occupied the board wee strings
        position_taken?(index)  
        end
    # @board.all?{|position| !position.empty? }
                            #the top and bottom are what students usually do. i did something different by checking to see if position was taken
    # @board.all? do |position|
    #     position != "" || position != " "
    # end

end

def draw?
    if full? && !won?
        true
    else
        false
    end
end

def over?
   if draw? || won?
    true 
   else
     false
   end
end

def winner
    if won?
        if current_player == "O"
            "X"
        elsif current_player == "X"
            "O"
        end
    else
        nil
    end

end

def play
    turn until over?

    if won?
       puts "Congratulations #{winner}!"
    elsif draw?
        puts "Cat's Game!"
    end
end


end

