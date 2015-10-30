require "pry"

board = [
  [:bR, nil, :bB, :bQ, :bK, nil, nil, :bR],
  [nil, nil, nil, :bP, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, :wP, nil, nil, nil, nil],
  [:wR, nil, nil, nil, nil, nil, nil, :wR]
]

module GameRules

  def is_cell_empty? dest
    @board[dest[0] - 1][dest[1] - 1].nil?
  end

  def is_enemy_in_cell?
    get_color != piece_color(dest)
  end

  private

  def piece_color coord
    @board[@coord[0] - 1][@coord[1] - 1].to_s.gsub(/./).first.to_sym
  end
end

module PieceRules
  def rook_move dest
    (@position[0] == dest[0]) || (@position[1] == dest[1])
  end

  def bishop_move dest
    (@position[0] - dest[0]).abs == (@position[1] - dest[1]).abs
  end

  def queen_move dest
    rook_move(dest) || bishop_move(dest)
  end

  def king_move dest
    ((@position[0] - dest[0]).abs <= 1) || ((@position[1] - dest[1]).abs <= 1)
  end

  def pawn_move dest
    if get_color == :w
      @position[0] - 1 == dest[0]
    else
      @position[0] + 1 == dest[0]
    end
  end

  def knight_move dest

  end
end

class Piece
  include GameRules
  include PieceRules

  def initialize board, position
    @board = board
    @position = position
  end

  def get_color
    @board[@position[0] - 1][@position[1] - 1].to_s.gsub(/./).first.to_sym
  end
end

class Rook < Piece
  def move dest

    rook_move(dest)
  end
end

class Bishop < Piece
  def move dest
    if is_cell_empty?(dest) && bishop_move(dest)
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
  end
end

class Queen < Piece
  def move dest
    if is_cell_empty?(dest) && queen_move(dest)
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
  end
end

class King < Piece
  def move dest
    if is_cell_empty?(dest) && king_move(dest)
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
  end
end

class Pawn < Piece
  def move dest
    if is_cell_empty?(dest) && pawn_move(dest)
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
  end
end

rook = Rook.new board, [1,1]
rook.move [1,7]

bishop = Bishop.new board, [1,3]
bishop.move [4,6]

queen = Queen.new board, [1,4]
queen.move [5,4]

king = King.new board, [1,5]
king.move [2,5]

pawn = Pawn.new board, [2,4]
pawn.move [3,4]

pawn = Pawn.new board, [7,4]
pawn.move [6,4]
