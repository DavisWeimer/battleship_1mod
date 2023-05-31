require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/methodable'

class Game
include Methodable
  def main_menu
    puts "Welcome to BATTLESHIP"
    user_input = ""
    until user_input == "p" do
      puts "Enter p to play. Enter q to quit."
      user_input = gets.chomp.downcase
      if user_input == "p"
        puts "\n"
        puts "Starting the game..."
        puts "\n"
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
    @npc_random_coords = @npc_board.cells.keys.shuffle!
    @npc_index = 0

    @npc_board.place(@npc_cruiser, coord_randomizer(@npc_cruiser)) 
    @npc_board.place(@npc_submarine, coord_randomizer(@npc_submarine)) 
  end

  def player_setup
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2) 
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render

    user_input = ""

    until @player_board.valid_placement?(@player_cruiser, [user_input].flatten) do
      puts "Enter the squares for the Cruiser (3 spaces):"
      print "> "
      user_input = gets.chomp.upcase.split
      if @player_board.valid_placement?(@player_cruiser, [user_input].flatten) == false
        puts "Those are invalid coordinates. Please try again:"
        print "> "
        user_input = gets.chomp.upcase.split
      end
    end

    @player_board.place(@player_cruiser, [user_input].flatten)

    until @player_board.valid_placement?(@player_submarine, [user_input].flatten) do
      puts "Enter the squares for the Submarine (2 spaces):"
      print "> "
      user_input = gets.chomp.upcase.split
      if @player_board.valid_placement?(@player_submarine, [user_input].flatten) == false
        puts "Those are invalid coordinates. Please try again:"
        print "> "
        user_input = gets.chomp.upcase.split
      end
    end

    @player_board.place(@player_submarine, [user_input].flatten)
    display_boards
    player_shot
  end

  def display_boards
    puts "\n"
    puts "=============COMPUTER BOARD============="
    puts @npc_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_shot
    puts "\n"
    until sunk_check?(@npc_board) || sunk_check?(@player_board)
      user_input = ""
      until @npc_board.valid_coordinate?(user_input) do
        puts "Enter the coordinate for your shot:"
        print "> "
        user_input = gets.chomp.upcase
        if @npc_board.valid_coordinate?(user_input) == false
          puts "Please enter a valid coordinate:"
          print "> "
        end
      end
      @npc_board.cells[user_input].fire_upon
      @player_board.cells[array_mover].fire_upon
      display_boards
      npc_result(user_input)
      player_result(array_mover)
    end
  end

  
end