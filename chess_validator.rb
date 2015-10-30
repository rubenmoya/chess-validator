require "pry"

board = [
  [:bR, :bN, :bB, :bQ, :bK, :bB, :bN, :bR],
  [:bP, :bP, :bP, :bP, :bP, :bP, :bP, :bP],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil],
  [:wP, :wP, :wP, :wP, :wP, :wP, :wP, :wP],
  [:wR, :wN, :wB, :wQ, :wK, :wB, :wN, :wR],
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
    @board[@coord[0]][@coord[1]].to_s.chars.first.to_sym
  end
end

module PieceRules
  def is_horizontal? dest
    (@position[0] == dest[0])
  end

  def is_vertical? dest
    (@position[1] == dest[1])
  end

  def rook_move dest
    is_vertical?(dest) || is_horizontal?(dest)
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
    if(@position[0] == 1 || @position[0] == 6)
      is_vertical?(dest) && pawn_first_move(dest)
    else
      is_vertical?(dest) && pawn_generic_move(dest)
    end
  end

  def pawn_first_move dest
    if @color == :w
      (@position[0] - dest[0]).between?(1, 2)
    else
      (@position[0] - dest[0]).between?(-2, -1)
    end
  end

  def pawn_generic_move dest
    if @color == :w
      (@position[0] - dest[0]) == -1
    else
      (@position[0] - dest[0]) == 1
    end
  end

  def knight_move dest
    (@position[0] - dest[0]).abs == 2 && (@position[1] - dest[1]).abs == 1
  end
end

class ChessValidator
  def initialize board
    @board = board
  end

  def validate movements
    movements = movements.split("\n")

    movements.each do |m|
      positions = parse_position m
      start_position = positions[0]
      dest_position = positions[1]

      piece_type = get_piece_type start_position

      case piece_type
      when :R
        rook = Rook.new @board, start_position
        rook.move dest_position

      when :N
        knight = Knight.new @board, start_position
        knight.move dest_position

      when :B
        bishop = Bishop.new @board, start_position
        bishop.move dest_position

      when :Q
        queen = Queen.new @board, start_position
        queen.move dest_position

      when :K
        king = King.new @board, start_position
        king.move dest_position

      when :P
        pawn = Pawn.new @board, start_position
        pawn.move dest_position
      else
        puts "ILEGAL"
      end
    end
  end

  def get_piece_type position
    @board[position[0]][position[1]].to_s.chars.last.to_sym unless @board[position[0]][position[1]].nil?
  end

  def parse_position position
    start_letter = parse_letter position.chars[0]
    start_number = parse_number position.chars[1]

    dest_letter = parse_letter position.chars[3]
    dest_number = parse_number position.chars[4]

    [[start_number, start_letter], [dest_number, dest_letter]]
  end

  def parse_letter letter
    ("a".."h").to_a.index letter
  end

  def parse_number number
    (1..8).to_a.reverse.index number.to_i
  end
end

class Piece
  include GameRules
  include PieceRules

  def initialize board, position
    @board = board
    @position = position
    @color = get_color
  end

  def get_color
    @board[@position[0]][@position[1]].to_s.chars.first.to_sym
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

movements = IO.read("simple_moves.txt")

validator = ChessValidator.new board
validator.validate movements
