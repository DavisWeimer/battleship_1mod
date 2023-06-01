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
    ship_cells = Array.new
    board.cells.values.each do |cell|
      if cell.ship != nil
      ship_cells << cell.ship
      end
    end
    ship_cells.all? do |ship|
        ship.sunk?
    end
  end
  
  def coord_check?(user_input)
    user_input.all? do |coord|
      @player_board.valid_coordinate?(coord)
    end
  end

  def array_mover
    element = @npc_random_coords[@npc_index]
    @npc_index += 1
    element
  end

  def npc_result(coordinate)
    if @npc_board.cells[coordinate].render == "M"
      puts "Your shot on #{coordinate} was a miss."
    elsif @npc_board.cells[coordinate].render == "H"
      puts "Your shot on #{coordinate} was a hit!"
    elsif @npc_cruiser.sunk?
      puts "Your shot on #{coordinate} sunk my Cruiser!"
    else @npc_submarine.sunk?
      puts "Your shot on #{coordinate} sunk my Submarine!"
    end
  end

  def player_result(coordinate)
    if @player_board.cells[coordinate].render == "M"
      puts "My shot on #{coordinate} was a miss."
    elsif @player_board.cells[coordinate].render == "H"
      puts "My shot on #{coordinate} was a hit!"
    elsif @player_cruiser.sunk?
      puts "My shot on #{coordinate} sunk your Cruiser!"
    else @player_submarine.sunk?
      puts "My shot on #{coordinate} sunk your Submarine!"
    end
  end

end