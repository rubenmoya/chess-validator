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
