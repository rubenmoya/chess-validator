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
