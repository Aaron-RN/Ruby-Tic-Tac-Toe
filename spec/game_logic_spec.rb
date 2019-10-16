# frozen_string_literal: true

require './lib/game_logic.rb'
require './lib/player.rb'

RSpec.describe BoardLogic do
  let(:player_one) { Player.new('X', 'green') }
  let(:player_two) { Player.new('O', 'red') }
  let(:game) { BoardLogic.new(rows = 3, cols = 3) }

  describe '#game_over?' do
    it 'Returns the winning player when the winning combo matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(1)
      player_one.position(2)
      player_one.position(3)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end

    it 'Returns a draw if neither player has won and no more positions are available on the board' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      (1..game.cols * game.rows).each do |i|
        game.move_made(game.player_turn, i)
      end
      expect(game.winner).to eql(nil)
      expect(game.game_over).to eql(true)
    end

    it 'Returns the winning player when a player has 3 matches in a row
       and no more positions are available on the board' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(1)
      player_one.position(5)
      player_one.position(9)
      (1..game.cols * game.rows).each do |i|
        game.move_made(game.player_turn, i)
      end
      expect(game.winner).to eql(player_one)
    end
  end

  describe '#check_board_pos' do
    it 'Checks if the position on the board is available or not' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      game.move_made(game.player_turn, 9)
      expect(check_board_pos(game, 9)).to eql([false, 'Position already taken'])
    end

    it 'Checks if the position is a valid input' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      expect(check_board_pos(game, 'S'.to_i)).to eql([false, 'Invalid input'])
    end

    it 'Returns true if position is available' do
      expect(check_board_pos(game, 9)).to eql([true])
    end
  end
end
