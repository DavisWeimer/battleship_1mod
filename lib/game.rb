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
        game_time
      elsif user_input == "q"
        puts "Quitting :("
        exit # run the quit game method
      else
        puts "Wrong input, try again"
      end
    end
  end 

  def game_time 
    npc_setup
    player_setup
  end

  def npc_setup 
    @npc_board = Board.new
    @npc_cruiser = Ship.new("Cruiser", 3)
    @npc_submarine = Ship.new("Submarine", 2)
    @npc_board.place(@npc_cruiser, coord_randomizer(@npc_cruiser)) 
    @npc_board.place(@npc_submarine, coord_randomizer(@npc_submarine)) 
    
  end

  def player_setup
    @player_board = Board.new

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

  def coord_randomizer(ship)
    valid_horiz_coords(ship).concat(valid_vert_coords(ship)).sample
  end
end