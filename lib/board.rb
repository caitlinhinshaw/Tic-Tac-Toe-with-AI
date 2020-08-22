require 'pry'

class Board
  attr_accessor :cells

  def initialize
    self.reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def position(input)
    @cells[input_to_index(input)]
  end

  def full?
    @cells.none? do |index|
      index.nil? || index == " "
    end
  end

  def turn_count
    occupied_spaces = 0
    @cells.each do |space|
      if space === "X" || space === "O"
        occupied_spaces += 1
      end
    end
    occupied_spaces
  end

  def taken?(index)
    !(position(index).nil? || position(index) == " " || position(index) == "")
  end

  def empty?(index)
    !taken?(index)
  end

  def valid_move?(index)
    #binding.pry
    taken?(index) == false && input_to_index(index).between?(0,8)
  end

  def update(input, player)
    @cells[input_to_index(input)] = player.token
  end
end
