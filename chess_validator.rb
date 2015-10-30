require "pry"

board = [
  [:bR, nil, nil, nil, nil, nil, nil, :bR],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [:bR, nil, nil, nil, nil, nil, nil, :wR]
]

module CheckMove
  def rook_move
    (@start[0] == @dest[0]) || (@start[1] == @dest[1])
  end

  def bishop_move
    (@start[0] - @dest[0]).abs == (@start[1] - @dest[1]).abs
  end

  def valid_position?
    start_color = piece_color? @start
    dest_color = piece_color? @dest

    is_cell_empty? || (start_color != dest_color)
  end

  def is_cell_empty?
    @board[@dest[0] - 1][@dest[1] - 1].nil?
  end

  def piece_color? piece
    @board[piece[0] - 1][piece[1] - 1].to_s.start_with?("w")
  end
end

class Piece
  include CheckMove

  def initialize board, start, dest
    @board = board
    @start = start
    @dest = dest
  end

  def legal_move?
    if valid_position? && valid_move?
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
  end
end

class Rook < Piece
  def valid_move?
    rook_move
  end
end

class Bishop < Piece
  def valid_move?
    bishop_move
  end
end

class Queen < Piece
  def valid_move?
    rook_move || bishop_move
  end
end

rook = Rook.new board, [1,1], [1,7]
rook.legal_move?

bishop = Bishop.new board, [4,2], [5,3]
bishop.legal_move?

queen = Queen.new board, [4,2], [5,3]
queen.legal_move?
