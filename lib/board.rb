# frozen_string_literal: true

class Board
  def initialize
    @board_state = Array.new(9)
    (0...9).each { |ind| @board_state[ind] = ind + 1 }
  end

  def display
    puts nil
    puts "        #{@board_state[0]} | #{@board_state[1]} | #{@board_state[2]}"
    puts '      -------------'
    puts "        #{@board_state[3]} | #{@board_state[4]} | #{@board_state[5]}"
    puts '      -------------'
    puts "        #{@board_state[6]} | #{@board_state[7]} | #{@board_state[8]}"
    puts nil
  end

  def set_tile(tile_num, val)
    @board_state[tile_num - 1] = val
  end

  def get_tile(tile_num)
    @board_state[tile_num - 1]
  end
end
