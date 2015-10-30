require "pry"

board = [
  [:bR, :bN, :bB, :bQ, :bK, nil, nil, :bR],
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
    @board[dest[0]][dest[1] - 1].nil?
  end

  def is_enemy_in_cell?
    get_color != piece_color(dest)
  end

  private

  def piece_color coord
    @board[@coord[0]][@coord[1]].to_s.gsub(/./).first.to_sym
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
    x_move = (@position[0] - dest[0]).abs
    y_move = (@position[1] - dest[1]).abs
    (x_move == 1) || (y_move == 1)
  end

  def pawn_move dest
    if get_color == :w
      @position[0] - 1 == dest[0]
    else
      @position[0] + 1 == dest[0]
    end
  end

  def knight_move dest
    (@position[0] - dest[0]).abs == 2 && (@position[1] - dest[1]).abs == 1
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
    @board[@position[0]][@position[1]].to_s.gsub(/./).first.to_sym
  end
end

class Rook < Piece
  def move dest
    if is_cell_empty?(dest) && rook_move(dest)
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
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
    if king_move(dest)
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

class Knight < Piece
  def move dest
    if is_cell_empty?(dest) && knight_move(dest)
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
  end
end

rook = Rook.new board, [0, 0]
rook.move [0, 6]

bishop = Bishop.new board, [0, 2]
bishop.move [3, 5]

queen = Queen.new board, [0, 3]
queen.move [4, 3]

king = King.new board, [0, 4]
king.move [1, 4]

pawn = Pawn.new board, [1, 3]
pawn.move [2, 3]

pawn = Pawn.new board, [6, 3]
pawn.move [5, 3]

knight = Knight.new board, [0,1]
knight.move [2, 2]
