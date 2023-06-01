class Cell
  attr_reader :coordinate, :ship, :cell_fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil 
    @cell_fired_upon = false
  end

  def empty?
    !@ship
  end

  def place_ship(new_ship)
    @ship = new_ship
  end

  def fired_upon?
    @cell_fired_upon
  end

  def fire_upon
    @cell_fired_upon = true
    if @ship 
      @ship.hit
    end
  end

  def render(show = false)
    if fired_upon? && empty?
      return "M"
    elsif fired_upon? && !empty? && @ship.sunk? == false
      return "H"
    elsif fired_upon? && @ship.sunk?
      return "X"
    end

    return "S" if show == true && !empty?
    
    "."
  end
end