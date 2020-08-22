class Game
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left column
    [1,4,7], # Middle column
    [2,5,8], # Right column
    [0,4,8], # Left diagonal
    [2,4,6]  # Right diagonal
  ]

  attr_accessor :player_1, :player_2, :board

  def initialize (player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def board
    @board
  end

  def player_1
    @player_1
  end

  def player_2
    @player_2
  end

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end

  def won?
    WIN_COMBINATIONS.find do |combination|
        if @board.cells[combination[0]] == @board.cells[combination[1]] &&
          @board.cells[combination[1]] == @board.cells[combination[2]] &&
          @board.taken?(combination[0]+1) #+1 bc #taken? receives user input
          return combination
        end
      end
    return false
  end

  def draw?
    @board.full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      @board.cells[won?[0]]
    end
  end

  def turn
    if board.turn_count == 0
      board.display
    end
    puts "\nTurn #{board.turn_count + 1}"
    puts "Player #{current_player.token}, please enter 1-9:"
    input = current_player.move(board)
    if board.valid_move?(input)
      board.update(input, current_player)
    else
      puts "#{input} is not a valid move. Please enter 1-9:"
      turn
    end
    board.display
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
