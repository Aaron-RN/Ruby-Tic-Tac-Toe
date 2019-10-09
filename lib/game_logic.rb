require './bin/main'

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

def check_board_pos(board, pos_chosen)
  if pos_chosen.Integer?
    pos_chosen.abs
    # if
    pos_chosen - 1 < board.length ? true : getPlayerInput
  end
  return true if board[pos_chosen - 1].Integer?

  false
end
