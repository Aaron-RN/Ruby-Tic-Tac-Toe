# frozen_string_literal: true

require_relative '../lib/game_logic.rb'
require_relative '../lib/player.rb'

RSpec.describe BoardLogic do
  let(:player_one) { Player.new('X', 'green') }
  let(:player_two) { Player.new('O', 'red') }
  let(:game) { BoardLogic.new(3, 3) }

  describe '#whos_turn?' do
    it "Sets the game\'s current player\'s turn to the player supplied via the parameter" do
      game.whos_turn?(player_one)
      expect(game.player_turn).to eql(player_one)
    end
  end

  describe '#player_setup?' do
    it "Sets the game\'s player one and player two variables to the supplied parameter value" do
      game.player_setup(player_one, player_two)
      expect(game.player_one).to eql(player_one)
      expect(game.player_two).to eql(player_two)
    end
  end

  describe '#move_made?' do
    it "Sets the game\'s current player\'s turn to the player supplied via the parameter" do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      game.move_made(game.player_turn, 2)
      expect(game.board[2 - 1]).to eql(game.player_one.symbol.green)
    end
  end

  describe '#mark_position' do
    it "Sets the current player\'s symbol at the supplied position on the board" do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      mark_position(game, game.player_turn, 5)
      expect(game.board[5 - 1]).to eql(game.player_one.symbol.green)
    end
  end

  describe '#game_over?' do
    it 'Returns the winning player when the winning combo [1,2,3] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(1)
      player_one.position(2)
      player_one.position(3)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
    it 'Returns the winning player when the winning combo [4,5,6] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(4)
      player_one.position(5)
      player_one.position(6)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
    it 'Returns the winning player when the winning combo [7,8,9] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(7)
      player_one.position(9)
      player_one.position(8)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
    it 'Returns the winning player when the winning combo [7,4,1] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(4)
      player_one.position(1)
      player_one.position(7)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
    it 'Returns the winning player when the winning combo [8,5,2] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(8)
      player_one.position(5)
      player_one.position(2)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
    it 'Returns the winning player when the winning combo [9,6,3] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(9)
      player_one.position(6)
      player_one.position(3)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
    it 'Returns the winning player when the winning combo [7,5,3] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(7)
      player_one.position(5)
      player_one.position(3)
      game.game_over?
      expect(game.winner).to eql(player_one)
    end
    it 'Returns the winning player when the winning combo [9,5,1] matches the positioned marks' do
      game.whos_turn?(player_one)
      game.player_setup(player_one, player_two)
      player_one.position(1)
      player_one.position(9)
      player_one.position(5)
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

RSpec.describe Player do
  let(:player_one) { Player.new('X', 'green') }

  describe '#position?' do
    it 'Keeps track of all positions played by the player by added each parameter supplied into an array' do
      expect(player_one.position(8)).to eql([8])
    end
  end
end
