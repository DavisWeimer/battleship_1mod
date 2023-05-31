module Methodable
  
  def valid_horiz_coords(ship)
    key_coord = @npc_board.current_board.keys

    unvalidated_hoz_coords = []
    key_coord.each_cons(ship.length) {|coord| unvalidated_hoz_coords << coord}
    
    validated_hoz = unvalidated_hoz_coords.select do |coord_array|
      @npc_board.valid_placement?(ship, coord_array)
    end
  end

  def valid_vert_coords(ship)
    key_coord = @npc_board.current_board.keys
    vertical_coord = key_coord.sort_by.with_index {|element, index| [index % 4, element]}

    unvalidated_vert_coords = []
    vertical_coord.each_cons(ship.length) {|coord| unvalidated_vert_coords << coord}

    validated_vert = unvalidated_vert_coords.select do |coord_array|
      @npc_board.valid_placement?(ship, coord_array)
    end 
  end

  def coord_randomizer(ship)
    valid_horiz_coords(ship).concat(valid_vert_coords(ship)).sample
  end

  def sunk_check?(board)
    board.cells.all? do |cell|
      if cell.last.ship != nil
        cell.last.ship.sunk?
      else 
        false
      end
    end
  end
end