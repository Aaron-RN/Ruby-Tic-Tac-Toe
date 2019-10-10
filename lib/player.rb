# frozen_string_literal: true

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
