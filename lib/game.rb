require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def main_menu
    puts "Welcome to BATTLESHIP"
    user_input = ""
    until user_input == "p" do
      puts "Enter p to play. Enter q to quit."
      user_input = gets.chomp
      if user_input == "p"
        puts "Starting the game"
        setup
      elsif user_input == "q"
        puts "Quitting :("
        exit # run the quit game method
      else
        puts "Wrong input, try again"
      end
    end
  end 

  def setup 
    npc_setup
  end

  def npc_setup 
    @npc_board = Board.new
    @npc_cruiser = Ship.new("Cruiser", 3)
    @npc_submarine = Ship.new("Submarine", 2)

    valid_horiz_coords(@npc_cruiser)
    valid_vert_coords(@npc_cruiser)

    valid_horiz_coords(@npc_submarine)
    valid_vert_coords(@npc_submarine)
  end

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
end