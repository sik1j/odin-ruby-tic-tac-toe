# frozen_string_literal: true

require_relative 'board'
require_relative 'user'

class Game
  def initialize
    @turn_count = 0
    @game_board = Board.new
    loop do
      print 'Select Nought or Cross [x/o]: '
      input = gets.chomp.upcase
      unless %w[O X].include? input
        puts "\nPlease enter a valid input"
        next
      end

      if input == 'X'
        @user1 = User.new('Player 1', 'X')
        @user2 = User.new('Player 2', 'O')
      else
        @user1 = User.new('Player 1', 'O')
        @user2 = User.new('Player 2', 'X')
      end
      break
    end
    @current_player = @user1
    puts "\n#{@user1.name} is: #{@user1.symbol}"
    puts "#{@user2.name} is: #{@user2.symbol}"
  end

  def run
    @game_board.display
    @current_player = @current_player == @user1 ? @user2 : @user1
    get_turn
    return game_over if has_player_won?

    @turn_count += 1
    if @turn_count == 10
      puts 'The game is a tie'
      return true
    end
    false
  end

  def get_turn
    loop do
      print "#{@current_player.name} (#{@current_player.symbol}), select a board position [1-9]: "
      input = begin
        Integer(gets.chomp)
      rescue StandardError
        'a'
      end
      unless input.is_a? Numeric
        puts "\nPlease enter a valid number"
        next
      end
      unless @game_board.get_tile(input).is_a? Numeric
        puts "\nThat tile is occupied"
        next
      end

      @game_board.set_tile(input, @current_player.symbol)
      break
    end
  end

  def has_player_won?
    winning_lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 3, 7], [2, 5, 8], [2, 4, 6], [0, 4, 8]]
    winning_lines.each do |line|
      a = line[0]
      b = line[1]
      c = line[2]
      next unless @game_board.get_tile(a + 1) == @game_board.get_tile(b + 1) &&
                  @game_board.get_tile(b + 1) == @game_board.get_tile(c + 1)

      @winning_player = @game_board.get_tile(a) == @user1.symbol ? @user1 : @user2
      return true
    end
    false
  end

  def game_over
    @game_board.display
    puts "#{@winning_player.name} (#{@winning_player.symbol}), has won the game!"
    true
  end
end
