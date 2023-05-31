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
    require 'pry'; binding.pry
    display_boards
    player_shot
  end

  def display_boards
    require 'pry'; binding.pry
  end

  def player_shot
    require 'pry'; binding.pry
  end

  
end