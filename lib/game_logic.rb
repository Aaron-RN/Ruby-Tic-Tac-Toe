# frozen_string_literal: true

class BoardLogic
  attr_reader :board, :rows, :cols, :player_turn, :player_one, :player_two, :turns_taken, :max_turns

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @board = []
    @player_turn = nil
    @player_one = nil
    @player_two = nil
    @turns_taken = 0
    @max_turns = rows * cols
    for i in 1..@cols*@rows
      @board << i
    end
  end

  def whos_turn?(player)
    @player_turn = player
  end

  def player_setup(one, two)
    @player_one = one
    @player_two = two
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
    winning_combo = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
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
  error_pos = ''
  # results = [true, error_pos]

  if pos_chosen > 0 && pos_chosen <= game.max_turns
    if game.board[pos_chosen - 1].is_a? Integer
      return [true]
    else
      error_pos = 'Position already taken'
    end
  else
    error_pos = 'Invalid input'
  end

  [false, error_pos]
end

def mark_position(game, player, pos)
  player.position(pos)
  game.move_made(player, pos)
end
