# [
#   [:bR, :bN, :bB, :bQ, :bK, :bB, :bN, :bR],
#   [:bP, :bP, :bP, :bP, :bP, :bP, :bP, :bP],
#   [nil, nil, nil, nil, nil, nil, nil, nil],
#   [nil, nil, nil, nil, nil, nil, nil, nil],
#   [nil, nil, nil, nil, nil, nil, nil, nil],
#   [nil, nil, nil, nil, nil, nil, nil, nil],
#   [:wP, :wP, :wP, :wP, :wP, :wP, :wP, :wP],
#   [:aR, :aN, :aB, :aQ, :aK, :aB, :aN, :aR]
# ]

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

class Piece
  def is_valid_position? board, start, dest
    start_color = piece_color? board, start
    dest_color = piece_color? board, dest

    is_cell_empty?(board, dest) || (start_color != dest_color)
  end

  private

  def is_cell_empty? board, dest
    board[dest[0]-1][dest[1]-1].nil?
  end

  def piece_color? board, pos
    board[pos[0] - 1][pos[1] - 1].to_s.start_with?("w")
  end
end

class Rook < Piece
  def valid_move? board, start, dest
    is_valid_position?(board, start, dest) && (start[0] == dest[0])|| (start[1] == dest[1])
  end
end

rook = Rook.new
puts rook.valid_move? board, [1,1], [1,7]
