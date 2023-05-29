require './lib/cell'

class Board

  def cells
    board = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end 

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate) && !cells[coordinate].cell_fired_upon 
    # add test case for when cell fired upon is true
    # if cell has been fired upon?
  end

  def valid_placement?(ship, coord_array)
    return false if ship.length != coord_array.count
    return false if occupied(coord_array) == true

    letters = []
    numbers = []
    coord_array.each do |coord|
      letters << coord[0] 
      numbers << coord[1].to_i
    end

    consecutive?(letters) && same?(numbers) || consecutive?(numbers) && same?(letters)
   
  end

  def consecutive?(letters_or_numbers)
    consecutive = false
    check_consecutive = letters_or_numbers.first.ord
    letters_or_numbers.each do |letter|
      if letter.ord == check_consecutive
        consecutive = true
      else
        consecutive = false
      end
      check_consecutive += 1
    end
    consecutive
  end

  def same?(letters_or_numbers)
    letters_or_numbers.uniq.count == 1
  end
  
  def occupied(coord_array)
    coord_array.any? do |coord|
      !cells[coord].empty?
    end
  end
end


