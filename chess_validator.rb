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
  [:wR, nil, nil, nil, nil, nil, nil, :wR]
]

class Rook
  def valid_position? board, start, dest
    board[dest[0]][dest[1]]
    # board dest empty?
    # if not, what color is the piece?
    # cells until dest emtpy?
    # check if move is horizontal or vertical
  end
end

rook = Rook.new
rook.is_valid_position? board, [0,0], [2,2]
