require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/methodable'

class Game
include Methodable
  def main_menu
    welcome_title
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
        exit
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
    sunk_check?(@npc_board)
  end

  def player_setup
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2) 
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render

    user_input = "".split

    until coord_check?(user_input) && @player_board.valid_placement?(@player_cruiser, user_input) do
      puts "Enter the squares for the Cruiser (3 spaces):"
      print "> "
      user_input = gets.chomp.upcase.split
      if !coord_check?(user_input) || @player_board.valid_placement?(@player_cruiser, user_input) == false
        puts "Those are invalid coordinates. Please try again:"
        print "> "
        user_input = gets.chomp.upcase.split
      end
    end
    @player_board.place(@player_cruiser, [user_input].flatten)

    until coord_check?(user_input) && @player_board.valid_placement?(@player_submarine, user_input) do
      puts "Enter the squares for the Submarine (2 spaces):"
      print "> "
      user_input = gets.chomp.upcase.split
      if !coord_check?(user_input) || @player_board.valid_placement?(@player_submarine, user_input) == false
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
    until sunk_check?(@player_board) || sunk_check?(@npc_board) do
      user_input = ""
      npc_input = array_mover
      puts "Enter the coordinate for your shot:"
      print "> "
      user_input = gets.chomp.upcase
      if @npc_board.valid_coordinate?(user_input) == false
        puts "Please enter a valid coordinate:"
        print "> "
        user_input = gets.chomp.upcase
      end
      @npc_board.cells[user_input].fire_upon
      @player_board.cells[npc_input].fire_upon 
      display_boards
      npc_result(user_input)
      player_result(npc_input)
    end
  end_game
  end

  def end_game
    user_input = ""
    if sunk_check?(@player_board) && sunk_check?(@npc_board)
      puts "What are the odds, we tied human.."
    elsif sunk_check?(@npc_board)
      puts "You won!"
    else sunk_check?(@player_board)
      puts "I won!"
    end
    until user_input == "y" do
      puts "Would you like to play again? Press y/n"
      print "> "
      user_input = gets.chomp.downcase
      if user_input == "y"
        puts "\n"
        puts "Starting the game..."
        puts "\n"
        game_time
      elsif user_input == "n"
        puts "Goodbye..."
        exit 
      else
        puts "Wrong input, try again"
      end
    end
  end
end