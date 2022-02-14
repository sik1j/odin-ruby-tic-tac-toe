# frozen_string_literal: true

require_relative 'lib/game'

game = Game.new

loop do
  is_game_over = game.run
  break if is_game_over
end
