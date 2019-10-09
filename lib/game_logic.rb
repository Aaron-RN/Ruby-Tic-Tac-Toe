# frozen_string_literal: true

class BoardLogic
  attr_reader :board, :rows, :cols, :player_turn, :turns_taken, :max_turns

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @board = []
    @player_turn = nil
    @turns_taken = 0
    @max_turns = rows * cols
    for i in 1..@cols*@rows
      @board << i
    end
  end

  def whos_turn?(player)
    @player_turn = player
  end

  def move_made(player, pos)
    @board[pos - 1] = player.symbol.to_s.green if player.color == 'green'
    @board[pos - 1] = player.symbol.to_s.red if player.color == 'red'
    @board[pos - 1] = player.symbol.to_s.blue if player.color == 'blue'
    @turns_taken += 1
    game_over?
  end

  def draw?
    puts 'DRAW!' if @turns_taken >= @max_turns
  end

  def game_over?
    @board.each_with_index do |item, i|
      print i, item unless @board[i].is_a? Integer
      puts "\n"
    end
    draw?
  end
end
class Player
  attr_reader :symbol, :positions_mark, :color

  def initialize(symbol, color)
    @symbol = symbol
    @positions_mark = []
    @color = color
  end

  def position(mark)
    @positions_mark << mark
  end
end

def check_board_pos(game, pos_chosen)
  if pos_chosen.is_a? Integer
    pos_chosen.abs
    # if
    pos_chosen - 1 < game.board.length ? true : getPlayerInput
  else
    getPlayerInput
  end
  return true if game.board[pos_chosen - 1].is_a? Integer

  false
end

def mark_position(game, player, pos)
  player.position(pos)
  game.move_made(player, pos)
end
