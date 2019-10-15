# frozen_string_literal: true

require './lib/game_logic.rb'
require './lib/player.rb'

RSpec.describe BoardLogic do
  let(:player_one) { Player.new('X', 'green') }
  let(:player_two) { Player.new('O', 'red') }
  let(:game) { BoardLogic.new(rows = 3, cols = 3) }

  describe '#game.game_over?' do
    it 'Returns the winning player when the winning combo matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position([1, 2, 3])
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
  end

  # describe '#whos_turn?' do
  #   it 'Shows whose turn is next' do
  #     expect(@player_turn).to eql(player)
  #   end
  # end

end
