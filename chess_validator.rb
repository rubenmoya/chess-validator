require "pry"
require "./game_rules"
require "./piece_rules"

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

class Board
  def initialize board
    @board = board
  end

  def parse_board

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

      pieces = {:R => Rook, :N => Knight, :B => Bishop, :Q => Queen, :K => King, :P => Pawn}
      
      if pieces[piece_type]
        pieces[piece_type].new(@board, start_position).move(dest_position)
      else
        puts "ILEGAL"
      end
    end
  end

  private

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
