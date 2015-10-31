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
    vertical_difference = ((@position[0] - dest[0]).abs)
    horizontal_difference = ((@position[1] - dest[1]).abs)

    vertical_difference <= 1 && horizontal_difference <= 1
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
      (@position[0] - dest[0]) == 1
    else
      (@position[0] - dest[0]) == -1
    end
  end

  def knight_move dest
    x = (@position[0] - dest[0]).abs
    y = (@position[1] - dest[1]).abs

    (x <= 2 && y <= 2) && ((x == 2 && y == 1) || (x == 1 && y == 2))
  end
end
